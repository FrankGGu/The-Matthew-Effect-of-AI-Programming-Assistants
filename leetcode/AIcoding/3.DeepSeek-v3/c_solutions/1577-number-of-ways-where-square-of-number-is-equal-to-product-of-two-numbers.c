int numTriplets(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long long count = 0;

    // Count frequencies for nums2
    int max2 = 0;
    for (int i = 0; i < nums2Size; i++) {
        if (nums2[i] > max2) max2 = nums2[i];
    }

    int* freq2 = (int*)calloc(max2 + 1, sizeof(int));
    for (int i = 0; i < nums2Size; i++) {
        freq2[nums2[i]]++;
    }

    // Process nums1
    for (int i = 0; i < nums1Size; i++) {
        long long target = (long long)nums1[i] * nums1[i];

        for (int j = 0; j < nums2Size; j++) {
            if (target % nums2[j] != 0) continue;

            long long other = target / nums2[j];
            if (other > max2 || other < 1) continue;

            if (other == nums2[j]) {
                count += (freq2[other] - 1);
            } else {
                count += freq2[other];
            }
        }
    }

    count /= 2;

    // Count frequencies for nums1
    int max1 = 0;
    for (int i = 0; i < nums1Size; i++) {
        if (nums1[i] > max1) max1 = nums1[i];
    }

    int* freq1 = (int*)calloc(max1 + 1, sizeof(int));
    for (int i = 0; i < nums1Size; i++) {
        freq1[nums1[i]]++;
    }

    // Process nums2
    for (int i = 0; i < nums2Size; i++) {
        long long target = (long long)nums2[i] * nums2[i];

        for (int j = 0; j < nums1Size; j++) {
            if (target % nums1[j] != 0) continue;

            long long other = target / nums1[j];
            if (other > max1 || other < 1) continue;

            if (other == nums1[j]) {
                count += (freq1[other] - 1);
            } else {
                count += freq1[other];
            }
        }
    }

    count /= 2;

    free(freq1);
    free(freq2);

    return count;
}