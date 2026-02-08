typedef struct {
    int* nums;
    int numsSize;
} Solution;

Solution* solutionCreate(int* nums, int numsSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->nums = nums;
    obj->numsSize = numsSize;
    return obj;
}

int solutionPick(Solution* obj, int target) {
    int count = 0;
    int result = -1;

    for (int i = 0; i < obj->numsSize; i++) {
        if (obj->nums[i] == target) {
            count++;
            if (rand() % count == 0) {
                result = i;
            }
        }
    }

    return result;
}

void solutionFree(Solution* obj) {
    free(obj);
}