int countAlmostEqualPairs(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int count = 0;
    int freq[200001] = {0};

    for (int i = 0; i < nums1Size; i++) {
        freq[nums1[i] - nums2[i] + 100000]++;
    }

    for (int i = 0; i < nums2Size; i++) {
        count += freq[100000 - nums2[i] + nums1[i]];
        if (nums1[i] == nums2[i]) {
            count--;
        }
    }

    return count;
}