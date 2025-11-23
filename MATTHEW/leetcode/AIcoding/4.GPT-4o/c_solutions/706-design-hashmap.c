#define SIZE 1000

typedef struct Node {
    int key;
    int value;
    struct Node* next;
} Node;

typedef struct MyHashMap {
    Node** table;
} MyHashMap;

MyHashMap* myHashMapCreate() {
    MyHashMap* map = (MyHashMap*)malloc(sizeof(MyHashMap));
    map->table = (Node**)malloc(sizeof(Node*) * SIZE);
    for (int i = 0; i < SIZE; i++) {
        map->table[i] = NULL;
    }
    return map;
}

int hash(int key) {
    return key % SIZE;
}

void myHashMapPut(MyHashMap* obj, int key, int value) {
    int index = hash(key);
    Node* curr = obj->table[index];
    while (curr) {
        if (curr->key == key) {
            curr->value = value;
            return;
        }
        curr = curr->next;
    }
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->value = value;
    newNode->next = obj->table[index];
    obj->table[index] = newNode;
}

int myHashMapGet(MyHashMap* obj, int key) {
    int index = hash(key);
    Node* curr = obj->table[index];
    while (curr) {
        if (curr->key == key) {
            return curr->value;
        }
        curr = curr->next;
    }
    return -1;
}

void myHashMapRemove(MyHashMap* obj, int key) {
    int index = hash(key);
    Node* curr = obj->table[index];
    Node* prev = NULL;
    while (curr) {
        if (curr->key == key) {
            if (prev) {
                prev->next = curr->next;
            } else {
                obj->table[index] = curr->next;
            }
            free(curr);
            return;
        }
        prev = curr;
        curr = curr->next;
    }
}

void myHashMapFree(MyHashMap* obj) {
    for (int i = 0; i < SIZE; i++) {
        Node* curr = obj->table[i];
        while (curr) {
            Node* temp = curr;
            curr = curr->next;
            free(temp);
        }
    }
    free(obj->table);
    free(obj);
}