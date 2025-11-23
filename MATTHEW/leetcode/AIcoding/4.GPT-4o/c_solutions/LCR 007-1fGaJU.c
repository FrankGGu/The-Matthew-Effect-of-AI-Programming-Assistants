typedef struct {
    int* array;
    int size;
} Result;

Result* threeSum(int* nums, int numsSize, int* returnSize) {
    Result* result = malloc(sizeof(Result));
    result->array = malloc(numsSize * numsSize * sizeof(int) * 3);
    result->size = 0;

    qsort(nums, numsSize, sizeof(int), cmp);

    for (int i = 0; i < numsSize - 2; i++) {
        if (i > 0 && nums[i] == nums[i - 1]) continue;
        int left = i + 1, right = numsSize - 1;
        while (left < right) {
            int sum = nums[i] + nums[left] + nums[right];
            if (sum == 0) {
                result->array[result->size * 3] = nums[i];
                result->array[result->size * 3 + 1] = nums[left];
                result->array[result->size * 3 + 2] = nums[right];
                result->size++;

                while (left < right && nums[left] == nums[left + 1]) left++;
                while (left < right && nums[right] == nums[right - 1]) right--;
                left++;
                right--;
            } else if (sum < 0) {
                left++;
            } else {
                right--;
            }
        }
    }

    *returnSize = result->size;
    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}