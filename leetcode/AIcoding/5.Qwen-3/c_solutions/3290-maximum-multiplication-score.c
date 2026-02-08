#include <stdio.h>
#include <stdlib.h>

int maxMultiply(const int* nums1, const int* nums2, int nums1Size, int nums2Size) {
    int maxScore = INT_MIN;
    for (int i = 0; i < nums1Size; i++) {
        for (int j = 0; j < nums2Size; j++) {
            int score = nums1[i] * nums2[j];
            if (score > maxScore) {
                maxScore = score;
            }
        }
    }
    return maxScore;
}