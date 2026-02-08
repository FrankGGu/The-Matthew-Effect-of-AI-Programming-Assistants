#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct HashMapNode {
    char *key;
    void *value;
    struct HashMapNode *next;
} HashMapNode;

typedef struct HashMap {
    HashMapNode **table;
    int capacity;
    int size;
} HashMap;

static unsigned int get_hash(const char *key, int capacity) {
    unsigned long hash = 5381;
    int c;
    while ((c = *key++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash % capacity;
}

HashMap *createHashMap(int capacity) {
    HashMap *map = (HashMap *)malloc(sizeof(HashMap));
    map->capacity = capacity;
    map->size = 0;
    map->table = (HashMapNode **)calloc(capacity, sizeof(HashMapNode *));
    return map;
}

void freeHashMap(HashMap *map) {
    for (int i = 0; i < map->capacity; i++) {
        HashMapNode *node = map->table[i];
        while (node) {
            HashMapNode *temp = node;
            free(node->key);
            node = node->next;
            free(temp);
        }
    }
    free(map->table);
    free(map);
}

void insertHashMap(HashMap *map, const char *key, void *value) {
    unsigned int index = get_hash(key, map->capacity);
    HashMapNode *node = map->table[index];

    while (node) {
        if (strcmp(node->key, key) == 0) {
            node->value = value;
            return;
        }
        node = node->next;
    }

    HashMapNode *newNode = (HashMapNode *)malloc(sizeof(HashMapNode));
    newNode->key = strdup(key);
    newNode->value = value;
    newNode->next = map->table[index];
    map->table[index] = newNode;
    map->size++;
}

void *getHashMap(HashMap *map, const char *key) {
    unsigned int index = get_hash(key, map->capacity);
    HashMapNode *node = map->table[index];

    while (node) {
        if (strcmp(node->key, key) == 0) {
            return node->value;
        }
        node = node->next;
    }
    return NULL;
}

typedef struct Person {
    char *name;
    struct Person **children;
    int numChildren;
    int capacityChildren;
    bool isDead;
} Person;

Person *createPerson(const char *name) {
    Person *p = (Person *)malloc(sizeof(Person));
    p->name = strdup(name);
    p->numChildren = 0;
    p->capacityChildren = 4;
    p->children = (Person **)malloc(p->capacityChildren * sizeof(Person *));
    p->isDead = false;
    return p;
}

void addChild(Person *parent, Person *child) {
    if (parent->numChildren == parent->capacityChildren) {
        parent->capacityChildren *= 2;
        parent->children = (Person **)realloc(parent->children, parent->capacityChildren * sizeof(Person *));
    }
    parent->children[parent->numChildren++] = child;
}

void freePerson(Person *p) {
    free(p->name);
    free(p->children);
    free(p);
}

typedef struct {
    char *kingName;
    HashMap *peopleMap;
} ThroneInheritance;

ThroneInheritance *throneInheritanceCreate(char *kingName) {
    ThroneInheritance *obj = (ThroneInheritance *)malloc(sizeof(ThroneInheritance));
    obj->kingName = strdup(kingName);
    obj->peopleMap = createHashMap(150007);

    Person *king = createPerson(kingName);
    insertHashMap(obj->peopleMap, kingName, king);

    return obj;
}

void throneInheritanceBirth(ThroneInheritance *obj, char *parentName, char *childName) {
    Person *parent = (Person *)getHashMap(obj->peopleMap, parentName);
    Person *child = createPerson(childName);

    addChild(parent, child);
    insertHashMap(obj->peopleMap, childName, child);
}

void throneInheritanceDeath(ThroneInheritance *obj, char *name) {
    Person *p = (Person *)getHashMap(obj->peopleMap, name);
    if (p) {
        p->isDead = true;
    }
}

typedef struct {
    char **names;
    int size;
    int capacity;
} NameList;

NameList *createNameList() {
    NameList *list = (NameList *)malloc(sizeof(NameList));
    list->size = 0;
    list->capacity = 16;
    list->names = (char **)malloc(list->capacity * sizeof(char *));
    return list;
}

void addName(NameList *list, const char *name) {
    if (list->size == list->capacity) {
        list->capacity *= 2;
        list->names = (char **)realloc(list->names, list->capacity * sizeof(char *));
    }
    list->names[list->size++] = strdup(name);
}

void dfs_inheritance_order(Person *current, NameList *resultList) {
    if (!current->isDead) {
        addName(resultList, current->name);
    }

    for (int i = 0; i < current->numChildren; i++) {
        dfs_inheritance_order(current->children[i], resultList);
    }
}

char **throneInheritanceGetInheritanceOrder(ThroneInheritance *obj, int *retSize) {
    Person *king = (Person *)getHashMap(obj->peopleMap, obj->kingName);

    NameList *resultList = createNameList();
    dfs_inheritance_order(king, resultList);

    *retSize = resultList->size;
    char **result = resultList->names;

    free(resultList);
    return result;
}

void throneInheritanceFree(ThroneInheritance *obj) {
    free(obj->kingName);

    for (int i = 0; i < obj->peopleMap->capacity; i++) {
        HashMapNode *node = obj->peopleMap->table[i];
        while (node) {
            Person *p = (Person *)node->value;
            freePerson(p);
            node = node->next;
        }
    }
    freeHashMap(obj->peopleMap);
    free(obj);
}