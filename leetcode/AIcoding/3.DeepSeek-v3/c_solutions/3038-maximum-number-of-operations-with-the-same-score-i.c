int maxOperations(int* nums, int numsSize) {
    if (numsSize < 2) return 0;

    int target = nums[0] + nums[1];
    int operations = 1;

    for (int i = 2; i < numsSize - 1; i += 2) {
        if (nums[i] + nums[i + 1] == target) {
            operations++;
        } else {
            break;
        }
    }

    return operations;
}