int getMinDistance(int* nums, int numsSize, int target, int start) {
    int minDistance = numsSize;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == target) {
            int distance = abs(i - start);
            if (distance < minDistance) {
                minDistance = distance;
            }
        }
    }
    return minDistance;
}