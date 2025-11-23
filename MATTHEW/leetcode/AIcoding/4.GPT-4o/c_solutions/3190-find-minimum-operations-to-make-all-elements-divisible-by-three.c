int minOperations(int* nums, int numsSize) {
    int count[3] = {0};
    for (int i = 0; i < numsSize; i++) {
        count[nums[i] % 3]++;
    }
    int operations = 0;
    operations += count[1] / 3;
    operations += count[2] / 3;
    count[1] %= 3;
    count[2] %= 3;

    while (count[1] > 0 && count[2] > 0) {
        operations++;
        count[1]--;
        count[2]--;
    }

    operations += count[1] + count[2] * 2;

    return operations;
}