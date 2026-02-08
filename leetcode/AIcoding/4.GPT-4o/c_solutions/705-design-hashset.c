typedef struct {
    bool *table;
} MyHashSet;

MyHashSet* myHashSetCreate() {
    MyHashSet* obj = (MyHashSet*)malloc(sizeof(MyHashSet));
    obj->table = (bool*)calloc(1000001, sizeof(bool));
    return obj;
}

void myHashSetAdd(MyHashSet* obj, int key) {
    obj->table[key] = true;
}

void myHashSetRemove(MyHashSet* obj, int key) {
    obj->table[key] = false;
}

bool myHashSetContains(MyHashSet* obj, int key) {
    return obj->table[key];
}

void myHashSetFree(MyHashSet* obj) {
    free(obj->table);
    free(obj);
}