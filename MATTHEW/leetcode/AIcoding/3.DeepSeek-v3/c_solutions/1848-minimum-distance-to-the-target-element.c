int getMinDistance(int* nums, int numsSize, int target, int start) {
    int minDist = numsSize;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == target) {
            int dist = abs(i - start);
            if (dist < minDist) {
                minDist = dist;
            }
        }
    }
    return minDist;
}