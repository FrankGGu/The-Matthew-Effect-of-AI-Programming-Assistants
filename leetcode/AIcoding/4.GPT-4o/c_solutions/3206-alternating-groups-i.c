typedef struct {
    int *data;
    int size;
    int capacity;
} DynamicArray;

DynamicArray* createDynamicArray(int capacity) {
    DynamicArray *array = malloc(sizeof(DynamicArray));
    array->data = malloc(capacity * sizeof(int));
    array->size = 0;
    array->capacity = capacity;
    return array;
}

void addToDynamicArray(DynamicArray *array, int value) {
    if (array->size == array->capacity) {
        array->capacity *= 2;
        array->data = realloc(array->data, array->capacity * sizeof(int));
    }
    array->data[array->size++] = value;
}

void freeDynamicArray(DynamicArray *array) {
    free(array->data);
    free(array);
}

int* alternatingGroups(int* nums, int numsSize, int* returnSize) {
    DynamicArray *result = createDynamicArray(numsSize);
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 0) {
            addToDynamicArray(result, nums[i]);
            count++;
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (i % 2 == 1) {
            addToDynamicArray(result, nums[i]);
            count++;
        }
    }

    *returnSize = count;
    return result->data;
}