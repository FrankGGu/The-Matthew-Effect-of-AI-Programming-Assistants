int minimumOperations(int* nums, int numsSize) {
    int freq[101] = {0};
    int i;
    for (i = numsSize - 1; i >= 0; i--) {
        if (freq[nums[i]] > 0) {
            break;
        }
        freq[nums[i]]++;
    }
    return (i + 1 + 2) / 3;
}