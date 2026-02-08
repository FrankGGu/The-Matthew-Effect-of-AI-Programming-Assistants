typedef struct {
    int* tree;
    int* nums;
    int size;
} NumArray;

NumArray* numArrayCreate(int* nums, int numsSize) {
    NumArray* obj = (NumArray*)malloc(sizeof(NumArray));
    obj->size = numsSize;
    obj->nums = (int*)malloc(sizeof(int) * numsSize);
    obj->tree = (int*)calloc(numsSize + 1, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        obj->nums[i] = nums[i];
        int index = i + 1;
        while (index <= numsSize) {
            obj->tree[index] += nums[i];
            index += index & -index;
        }
    }

    return obj;
}

void numArrayUpdate(NumArray* obj, int index, int val) {
    int diff = val - obj->nums[index];
    obj->nums[index] = val;
    int pos = index + 1;
    while (pos <= obj->size) {
        obj->tree[pos] += diff;
        pos += pos & -pos;
    }
}

int numArraySumRange(NumArray* obj, int left, int right) {
    int sumLeft = 0, sumRight = 0;

    int pos = left;
    while (pos > 0) {
        sumLeft += obj->tree[pos];
        pos -= pos & -pos;
    }

    pos = right + 1;
    while (pos > 0) {
        sumRight += obj->tree[pos];
        pos -= pos & -pos;
    }

    return sumRight - sumLeft;
}

void numArrayFree(NumArray* obj) {
    free(obj->tree);
    free(obj->nums);
    free(obj);
}