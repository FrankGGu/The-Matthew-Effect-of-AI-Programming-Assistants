typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} NumberMap;

typedef struct {
    NumberMap* map;
} NumberContainers;

NumberContainers* numberContainersCreate() {
    NumberContainers* obj = malloc(sizeof(NumberContainers));
    obj->map = NULL;
    return obj;
}

void numberContainersChange(NumberContainers* obj, int index, int number) {
    NumberMap* entry = NULL;
    HASH_FIND_INT(obj->map, &index, entry);
    if (entry) {
        entry->val = number;
    } else {
        entry = malloc(sizeof(NumberMap));
        entry->key = index;
        entry->val = number;
        HASH_ADD_INT(obj->map, key, entry);
    }
}

int numberContainersFind(NumberContainers* obj, int number) {
    NumberMap* entry;
    int min_index = INT_MAX;

    for(entry = obj->map; entry != NULL; entry = entry->hh.next) {
        if(entry->val == number && entry->key < min_index) {
            min_index = entry->key;
        }
    }

    return min_index == INT_MAX ? -1 : min_index;
}

void numberContainersFree(NumberContainers* obj) {
    NumberMap *current, *tmp;
    HASH_ITER(hh, obj->map, current, tmp) {
        HASH_DEL(obj->map, current);
        free(current);
    }
    free(obj);
}