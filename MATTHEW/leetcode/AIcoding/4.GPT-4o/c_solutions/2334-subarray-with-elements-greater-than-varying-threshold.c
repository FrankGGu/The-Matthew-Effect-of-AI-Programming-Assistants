int countSubarrays(int* nums, int numsSize, int threshold) {
    int count = 0, start = 0;
    for (int end = 0; end < numsSize; end++) {
        if (nums[end] > threshold) {
            start = end + 1;
        }
        count += end - start + 1;
    }
    return count;
}