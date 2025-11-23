int countSubarrays(int* nums, int numsSize, int minK, int maxK) {
    int count = 0, left = 0, lastMin = -1, lastMax = -1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < minK || nums[i] > maxK) {
            left = i + 1;
            lastMin = lastMax = -1;
        }
        if (nums[i] == minK) lastMin = i;
        if (nums[i] == maxK) lastMax = i;
        count += (lastMin != -1 && lastMax != -1) ? (1 + fmin(lastMin, lastMax) - left) : 0;
    }

    return count;
}