long long zeroFilledSubarray(int* nums, int numsSize) {
    long long count = 0;
    long long consecutive = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            consecutive++;
            count += consecutive;
        } else {
            consecutive = 0;
        }
    }

    return count;
}