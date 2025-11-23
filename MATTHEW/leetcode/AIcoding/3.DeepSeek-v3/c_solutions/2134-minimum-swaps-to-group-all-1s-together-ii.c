int minSwaps(int* nums, int numsSize) {
    int totalOnes = 0;
    for (int i = 0; i < numsSize; i++) {
        totalOnes += nums[i];
    }

    if (totalOnes == 0 || totalOnes == numsSize) {
        return 0;
    }

    int maxOnesInWindow = 0;
    int currentOnes = 0;

    for (int i = 0; i < totalOnes; i++) {
        currentOnes += nums[i];
    }
    maxOnesInWindow = currentOnes;

    for (int i = totalOnes; i < numsSize + totalOnes; i++) {
        currentOnes += nums[i % numsSize];
        currentOnes -= nums[(i - totalOnes) % numsSize];
        if (currentOnes > maxOnesInWindow) {
            maxOnesInWindow = currentOnes;
        }
    }

    return totalOnes - maxOnesInWindow;
}