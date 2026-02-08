int maximumScore(int* nums1, int nums1Size, int* nums2, int nums2Size, int k) {
    int maxScore = 0;
    for (int i = 0; i < nums1Size; i++) {
        for (int j = 0; j < nums2Size; j++) {
            if (nums1[i] == nums2[j]) {
                maxScore = maxScore > nums1[i] ? maxScore : nums1[i];
            }
        }
    }
    return maxScore * k;
}