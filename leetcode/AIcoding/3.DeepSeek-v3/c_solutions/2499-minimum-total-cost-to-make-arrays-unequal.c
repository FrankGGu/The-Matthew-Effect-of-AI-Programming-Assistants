int minTotalCost(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int n = nums1Size;
    int total = 0;
    int count = 0;
    int mode = 0;
    int modeCount = 0;
    int freq[100001] = {0};

    for (int i = 0; i < n; i++) {
        if (nums1[i] == nums2[i]) {
            freq[nums1[i]]++;
            if (freq[nums1[i]] > modeCount) {
                modeCount = freq[nums1[i]];
                mode = nums1[i];
            }
            total += i;
            count++;
        }
    }

    for (int i = 0; i < n && modeCount * 2 > count; i++) {
        if (nums1[i] != nums2[i] && nums1[i] != mode && nums2[i] != mode) {
            total += i;
            count++;
        }
    }

    if (modeCount * 2 > count) {
        return -1;
    }

    return total;
}