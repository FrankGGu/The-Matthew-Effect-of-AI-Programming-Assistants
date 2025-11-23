typedef struct {
    int* nums;
    int* tree;
    int size;
} NumArray;

void updateTree(NumArray* obj, int index, int value) {
    int delta = value - obj->nums[index];
    obj->nums[index] = value;
    index += 1;
    while (index <= obj->size) {
        obj->tree[index] += delta;
        index += index & -index;
    }
}

int sumTree(NumArray* obj, int index) {
    int sum = 0;
    index += 1;
    while (index > 0) {
        sum += obj->tree[index];
        index -= index & -index;
    }
    return sum;
}

NumArray* numArrayCreate(int* nums, int numsSize) {
    NumArray* obj = (NumArray*)malloc(sizeof(NumArray));
    obj->nums = (int*)malloc(numsSize * sizeof(int));
    obj->tree = (int*)calloc(numsSize + 1, sizeof(int));
    obj->size = numsSize;
    for (int i = 0; i < numsSize; i++) {
        obj->nums[i] = nums[i];
        updateTree(obj, i, nums[i]);
    }
    return obj;
}

void numArrayUpdate(NumArray* obj, int index, int val) {
    updateTree(obj, index, val);
}

int numArraySumRange(NumArray* obj, int left, int right) {
    return sumTree(obj, right) - sumTree(obj, left - 1);
}

void numArrayFree(NumArray* obj) {
    free(obj->nums);
    free(obj->tree);
    free(obj);
}