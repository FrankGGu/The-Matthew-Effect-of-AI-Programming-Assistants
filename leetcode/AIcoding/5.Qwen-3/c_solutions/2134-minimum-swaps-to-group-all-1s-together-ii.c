#include <stdio.h>
#include <stdlib.h>

int minSwaps(char* nums, int n) {
    int totalOnes = 0;
    for (int i = 0; i < n; i++) {
        if (nums[i] == '1') totalOnes++;
    }

    if (totalOnes == 0 || totalOnes == n) return 0;

    int windowSize = totalOnes;
    int maxOnesInWindow = 0;
    int currentOnes = 0;

    for (int i = 0; i < windowSize; i++) {
        if (nums[i] == '1') currentOnes++;
    }
    maxOnesInWindow = currentOnes;

    for (int i = windowSize; i < n; i++) {
        if (nums[i - windowSize] == '1') currentOnes--;
        if (nums[i] == '1') currentOnes++;
        if (currentOnes > maxOnesInWindow) maxOnesInWindow = currentOnes;
    }

    return windowSize - maxOnesInWindow;
}