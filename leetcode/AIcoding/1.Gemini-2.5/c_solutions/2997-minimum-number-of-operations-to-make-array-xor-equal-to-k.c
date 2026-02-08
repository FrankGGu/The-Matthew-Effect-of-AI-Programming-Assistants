int minOperations(int* nums, int numsSize, int k) {
    int current_xor_sum = 0;
    for (int i = 0; i < numsSize; i++) {
        current_xor_sum ^= nums[i];
    }

    int target_xor_diff = current_xor_sum ^ k;
    int operations = 0;

    while (target_xor_diff > 0) {
        target_xor_diff &= (target_xor_diff - 1);
        operations++;
    }

    return operations;
}