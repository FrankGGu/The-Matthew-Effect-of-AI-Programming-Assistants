int minSwaps(int* nums, int numsSize) {
    int totalOnes = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) {
            totalOnes++;
        }
    }

    if (totalOnes == 0 || totalOnes == numsSize) {
        return 0;
    }

    int currentOnes = 0;
    for (int i = 0; i < totalOnes; i++) {
        if (nums[i] == 1) {
            currentOnes++;
        }
    }

    int maxOnesInWindow = currentOnes;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i - 1] == 1) {
            currentOnes--;
        }
        if (nums[(i + totalOnes - 1) % numsSize] == 1) {
            currentOnes++;
        }

        if (currentOnes > maxOnesInWindow) {
            maxOnesInWindow = currentOnes;
        }
    }

    return totalOnes - maxOnesInWindow;
}