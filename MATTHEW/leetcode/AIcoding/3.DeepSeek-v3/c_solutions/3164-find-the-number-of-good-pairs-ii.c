typedef long long ll;

long long numberOfPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int k) {
    ll count = 0;
    int max1 = 0, max2 = 0;

    for (int i = 0; i < nums1Size; i++) {
        if (nums1[i] > max1) max1 = nums1[i];
    }
    for (int i = 0; i < nums2Size; i++) {
        if (nums2[i] > max2) max2 = nums2[i];
    }

    int max_val = (max1 > max2 * k) ? max1 : max2 * k;

    int* freq1 = (int*)calloc(max_val + 1, sizeof(int));
    int* freq2 = (int*)calloc(max_val + 1, sizeof(int));

    for (int i = 0; i < nums1Size; i++) {
        freq1[nums1[i]]++;
    }
    for (int i = 0; i < nums2Size; i++) {
        freq2[nums2[i]]++;
    }

    for (int i = 1; i <= max_val; i++) {
        if (freq2[i] == 0) continue;
        int multiple = i * k;
        for (int j = multiple; j <= max_val; j += multiple) {
            if (freq1[j] > 0) {
                count += (ll)freq1[j] * freq2[i];
            }
        }
    }

    free(freq1);
    free(freq2);
    return count;
}