#define MAX(a, b) ((a) > (b) ? (a) : (b))

long long largestElementAfterMerge(int* nums, int numsSize) {
    long long current_sum = nums[numsSize - 1];
    long long max_val = nums[numsSize - 1];

    for (int i = numsSize - 2; i >= 0; --i) {
        long long num = nums[i];
        if (num <= current_sum) {
            current_sum += num;
        } else {
            current_sum = num;
        }
        max_val = MAX(max_val, current_sum);
    }

    return max_val;
}