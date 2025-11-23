typedef struct {
    int* original;
    int* shuffled;
    int size;
} Solution;

Solution* solutionCreate(int* nums, int numsSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->original = (int*)malloc(numsSize * sizeof(int));
    obj->shuffled = (int*)malloc(numsSize * sizeof(int));
    obj->size = numsSize;
    for (int i = 0; i < numsSize; i++) {
        obj->original[i] = nums[i];
        obj->shuffled[i] = nums[i];
    }
    return obj;
}

int* solutionShuffle(Solution* obj, int* returnSize) {
    *returnSize = obj->size;
    for (int i = obj->size - 1; i > 0; i--) {
        int j = rand() % (i + 1);
        int temp = obj->shuffled[i];
        obj->shuffled[i] = obj->shuffled[j];
        obj->shuffled[j] = temp;
    }
    return obj->shuffled;
}

int* solutionReset(Solution* obj, int* returnSize) {
    *returnSize = obj->size;
    for (int i = 0; i < obj->size; i++) {
        obj->shuffled[i] = obj->original[i];
    }
    return obj->shuffled;
}

void solutionFree(Solution* obj) {
    free(obj->original);
    free(obj->shuffled);
    free(obj);
}