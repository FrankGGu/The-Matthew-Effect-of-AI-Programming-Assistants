int countAlternatingSubarrays(int* nums, int numsSize) {
    int count = 0, length = 0;
    for (int i = 0; i < numsSize; i++) {
        if (i > 0 && nums[i] != nums[i - 1]) {
            length++;
            count += length;
        } else {
            length = 0;
        }
    }
    return count;
}