typedef struct {
    long long *prefix;
    int size;
} NumArray;

NumArray* numArrayCreate(int* nums, int numsSize) {
    NumArray* obj = (NumArray*)malloc(sizeof(NumArray));
    obj->size = numsSize;
    obj->prefix = (long long*)malloc((numsSize + 1) * sizeof(long long));
    obj->prefix[0] = 1;
    for (int i = 1; i <= numsSize; i++) {
        obj->prefix[i] = obj->prefix[i - 1] * (long long)nums[i - 1];
    }
    return obj;
}

long long numArrayProductRange(NumArray* obj, int left, int right) {
    return obj->prefix[right + 1] / obj->prefix[left];
}

void numArrayFree(NumArray* obj) {
    free(obj->prefix);
    free(obj);
}