int maximumScore(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long sum1 = 0, sum2 = 0, maxScore = 0;

    for (int i = 0; i < nums1Size; i++) {
        sum1 += nums1[i];
    }
    for (int i = 0; i < nums2Size; i++) {
        sum2 += nums2[i];
    }

    long max1 = sum1, max2 = sum2;

    long currSum1 = 0, currSum2 = 0;

    for (int i = 0; i < nums1Size; i++) {
        currSum1 += nums1[i];
        currSum2 += nums2[i];
        max1 = fmax(max1, sum1 - currSum1 + currSum2);
        max2 = fmax(max2, sum2 - currSum2 + currSum1);
    }

    maxScore = fmax(max1, max2);

    return maxScore;
}