int maximumSetSize(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int freq1[100001] = {0};
    int freq2[100001] = {0};
    int common = 0;
    int n = nums1Size;

    for (int i = 0; i < n; i++) {
        freq1[nums1[i]] = 1;
        freq2[nums2[i]] = 1;
    }

    for (int i = 0; i < 100001; i++) {
        if (freq1[i] && freq2[i]) {
            common++;
        }
    }

    int unique1 = 0, unique2 = 0;
    for (int i = 0; i < 100001; i++) {
        if (freq1[i] && !freq2[i]) unique1++;
        if (freq2[i] && !freq1[i]) unique2++;
    }

    int take1 = fmin(unique1, n / 2);
    int take2 = fmin(unique2, n / 2);

    int remaining = n - take1 - take2;
    int takeCommon = fmin(common, remaining);

    return take1 + take2 + takeCommon;
}