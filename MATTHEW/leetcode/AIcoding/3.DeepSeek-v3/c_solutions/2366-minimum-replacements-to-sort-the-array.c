int minimumReplacement(int* nums, int numsSize) {
    long long operations = 0;
    int prev = nums[numsSize - 1];

    for (int i = numsSize - 2; i >= 0; i--) {
        if (nums[i] <= prev) {
            prev = nums[i];
            continue;
        }

        int parts = (nums[i] + prev - 1) / prev;
        operations += parts - 1;
        prev = nums[i] / parts;
    }

    return operations;
}