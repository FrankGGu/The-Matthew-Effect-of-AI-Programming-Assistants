int returnToBoundaryCount(int* nums, int numsSize) {
    int currentPosition = 0;
    int boundaryHits = 0;

    for (int i = 0; i < numsSize; i++) {
        currentPosition += nums[i];
        if (currentPosition == 0) {
            boundaryHits++;
        }
    }

    return boundaryHits;
}