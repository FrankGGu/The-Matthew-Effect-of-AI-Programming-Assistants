int maxOperations(int* nums, int numsSize) {
    int target_score = nums[0] + nums[1];
    int operations = 1;

    for (int i = 2; i + 1 < numsSize; i += 2) {
        if (nums[i] + nums[i+1] == target_score) {
            operations++;
        } else {
            break;
        }
    }

    return operations;
}