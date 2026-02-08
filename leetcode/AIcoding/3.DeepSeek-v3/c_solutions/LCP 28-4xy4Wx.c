int purchasePlans(int* nums, int numsSize, int target){
    qsort(nums, numsSize, sizeof(int), cmpfunc);
    int left = 0, right = numsSize - 1;
    long long count = 0;
    while (left < right) {
        if (nums[left] + nums[right] > target) {
            right--;
        } else {
            count += right - left;
            left++;
        }
        count %= 1000000007;
    }
    return count % 1000000007;
}

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}