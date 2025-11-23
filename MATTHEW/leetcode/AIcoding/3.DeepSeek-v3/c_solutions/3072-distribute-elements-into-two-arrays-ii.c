typedef struct {
    int key;
    int count;
    UT_hash_handle hh;
} HashNode;

typedef struct {
    int* arr;
    int size;
    int capacity;
} Array;

Array* createArray() {
    Array* arr = (Array*)malloc(sizeof(Array));
    arr->arr = (int*)malloc(sizeof(int) * 1000);
    arr->size = 0;
    arr->capacity = 1000;
    return arr;
}

void addToArray(Array* arr, int val) {
    if (arr->size == arr->capacity) {
        arr->capacity *= 2;
        arr->arr = (int*)realloc(arr->arr, sizeof(int) * arr->capacity);
    }
    arr->arr[arr->size++] = val;
}

int greaterCount(HashNode* map, int val) {
    int count = 0;
    HashNode *curr, *tmp;
    HASH_ITER(hh, map, curr, tmp) {
        if (curr->key > val) {
            count += curr->count;
        }
    }
    return count;
}

void addToMap(HashNode** map, int val) {
    HashNode* node;
    HASH_FIND_INT(*map, &val, node);
    if (node) {
        node->count++;
    } else {
        node = (HashNode*)malloc(sizeof(HashNode));
        node->key = val;
        node->count = 1;
        HASH_ADD_INT(*map, key, node);
    }
}

int* resultArray(int* nums, int numsSize, int* returnSize) {
    Array* arr1 = createArray();
    Array* arr2 = createArray();

    addToArray(arr1, nums[0]);
    addToArray(arr2, nums[1]);

    HashNode* map1 = NULL;
    HashNode* map2 = NULL;

    addToMap(&map1, nums[0]);
    addToMap(&map2, nums[1]);

    for (int i = 2; i < numsSize; i++) {
        int cnt1 = greaterCount(map1, nums[i]);
        int cnt2 = greaterCount(map2, nums[i]);

        if (cnt1 > cnt2) {
            addToArray(arr1, nums[i]);
            addToMap(&map1, nums[i]);
        } else if (cnt1 < cnt2) {
            addToArray(arr2, nums[i]);
            addToMap(&map2, nums[i]);
        } else {
            if (arr1->size < arr2->size) {
                addToArray(arr1, nums[i]);
                addToMap(&map1, nums[i]);
            } else if (arr1->size > arr2->size) {
                addToArray(arr2, nums[i]);
                addToMap(&map2, nums[i]);
            } else {
                addToArray(arr1, nums[i]);
                addToMap(&map1, nums[i]);
            }
        }
    }

    *returnSize = numsSize;
    int* result = (int*)malloc(sizeof(int) * numsSize);
    int idx = 0;

    for (int i = 0; i < arr1->size; i++) {
        result[idx++] = arr1->arr[i];
    }
    for (int i = 0; i < arr2->size; i++) {
        result[idx++] = arr2->arr[i];
    }

    free(arr1->arr);
    free(arr1);
    free(arr2->arr);
    free(arr2);

    HashNode *curr, *tmp;
    HASH_ITER(hh, map1, curr, tmp) {
        HASH_DEL(map1, curr);
        free(curr);
    }
    HASH_ITER(hh, map2, curr, tmp) {
        HASH_DEL(map2, curr);
        free(curr);
    }

    return result;
}