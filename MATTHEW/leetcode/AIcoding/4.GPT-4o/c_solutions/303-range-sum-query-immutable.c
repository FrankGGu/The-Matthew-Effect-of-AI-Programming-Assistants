typedef struct {
    int* sums;
    int size;
} NumArray;

NumArray* numArrayCreate(int* nums, int numsSize) {
    NumArray* obj = (NumArray*)malloc(sizeof(NumArray));
    obj->sums = (int*)malloc((numsSize + 1) * sizeof(int));
    obj->size = numsSize;
    obj->sums[0] = 0;
    for (int i = 1; i <= numsSize; i++) {
        obj->sums[i] = obj->sums[i - 1] + nums[i - 1];
    }
    return obj;
}

int numArraySumRange(NumArray* obj, int left, int right) {
    return obj->sums[right + 1] - obj->sums[left];
}

void numArrayFree(NumArray* obj) {
    free(obj->sums);
    free(obj);
}