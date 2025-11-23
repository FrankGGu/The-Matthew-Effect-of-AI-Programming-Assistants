typedef struct {
    int key;
    int value;
} Pair;

typedef struct {
    Pair *pairs;
    int size;
    int capacity;
} MyHashMap;

MyHashMap* myHashMapCreate() {
    MyHashMap *map = malloc(sizeof(MyHashMap));
    map->size = 0;
    map->capacity = 1000;
    map->pairs = malloc(sizeof(Pair) * map->capacity);
    return map;
}

void myHashMapPut(MyHashMap* obj, int key, int value) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->pairs[i].key == key) {
            obj->pairs[i].value = value;
            return;
        }
    }
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->pairs = realloc(obj->pairs, sizeof(Pair) * obj->capacity);
    }
    obj->pairs[obj->size].key = key;
    obj->pairs[obj->size].value = value;
    obj->size++;
}

int myHashMapGet(MyHashMap* obj, int key) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->pairs[i].key == key) {
            return obj->pairs[i].value;
        }
    }
    return -1;
}

void myHashMapRemove(MyHashMap* obj, int key) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->pairs[i].key == key) {
            obj->pairs[i] = obj->pairs[obj->size - 1];
            obj->size--;
            return;
        }
    }
}

void myHashMapFree(MyHashMap* obj) {
    free(obj->pairs);
    free(obj);
}