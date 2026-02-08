#include <stdlib.h>
#include <string.h>

typedef struct Person {
    char* name;
    int alive;
    struct Person** children;
    int childrenSize;
    int childrenCapacity;
} Person;

typedef struct {
    Person* king;
    Person** people;
    int peopleSize;
    int peopleCapacity;
} ThroneInheritance;

Person* createPerson(char* name) {
    Person* person = (Person*)malloc(sizeof(Person));
    person->name = (char*)malloc(strlen(name) + 1);
    strcpy(person->name, name);
    person->alive = 1;
    person->children = NULL;
    person->childrenSize = 0;
    person->childrenCapacity = 0;
    return person;
}

ThroneInheritance* throneInheritanceCreate(char* kingName) {
    ThroneInheritance* obj = (ThroneInheritance*)malloc(sizeof(ThroneInheritance));
    obj->king = createPerson(kingName);
    obj->people = (Person**)malloc(100000 * sizeof(Person*));
    obj->peopleSize = 0;
    obj->peopleCapacity = 100000;
    obj->people[obj->peopleSize++] = obj->king;
    return obj;
}

void throneInheritanceBirth(ThroneInheritance* obj, char* parentName, char* childName) {
    for (int i = 0; i < obj->peopleSize; i++) {
        if (strcmp(obj->people[i]->name, parentName) == 0) {
            Person* parent = obj->people[i];
            Person* child = createPerson(childName);
            if (parent->childrenSize >= parent->childrenCapacity) {
                parent->childrenCapacity = parent->childrenCapacity == 0 ? 4 : parent->childrenCapacity * 2;
                parent->children = (Person**)realloc(parent->children, parent->childrenCapacity * sizeof(Person*));
            }
            parent->children[parent->childrenSize++] = child;
            obj->people[obj->peopleSize++] = child;
            break;
        }
    }
}

void throneInheritanceDeath(ThroneInheritance* obj, char* name) {
    for (int i = 0; i < obj->peopleSize; i++) {
        if (strcmp(obj->people[i]->name, name) == 0) {
            obj->people[i]->alive = 0;
            break;
        }
    }
}

void dfs(Person* person, char*** order, int* returnSize) {
    if (person->alive) {
        (*order)[*returnSize] = (char*)malloc(strlen(person->name) + 1);
        strcpy((*order)[*returnSize], person->name);
        (*returnSize)++;
    }
    for (int i = 0; i < person->childrenSize; i++) {
        dfs(person->children[i], order, returnSize);
    }
}

char** throneInheritanceGetInheritanceOrder(ThroneInheritance* obj, int* returnSize) {
    char** order = (char**)malloc(100000 * sizeof(char*));
    *returnSize = 0;
    dfs(obj->king, &order, returnSize);
    return order;
}

void throneInheritanceFree(ThroneInheritance* obj) {
    for (int i = 0; i < obj->peopleSize; i++) {
        free(obj->people[i]->name);
        if (obj->people[i]->children) {
            free(obj->people[i]->children);
        }
        free(obj->people[i]);
    }
    free(obj->people);
    free(obj);
}