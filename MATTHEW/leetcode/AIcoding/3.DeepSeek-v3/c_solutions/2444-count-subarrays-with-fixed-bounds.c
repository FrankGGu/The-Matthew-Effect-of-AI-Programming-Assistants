int countSubarrays(int* nums, int numsSize, int minK, int maxK) {
    long long res = 0;
    int minPos = -1, maxPos = -1, leftBound = -1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < minK || nums[i] > maxK) {
            leftBound = i;
        }

        if (nums[i] == minK) {
            minPos = i;
        }

        if (nums[i] == maxK) {
            maxPos = i;
        }

        int smaller = minPos < maxPos ? minPos : maxPos;
        if (smaller > leftBound) {
            res += smaller - leftBound;
        }
    }

    return res;
}