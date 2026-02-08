int minNumber(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int count1[10] = {0};
    int count2[10] = {0};

    for (int i = 0; i < nums1Size; i++) {
        count1[nums1[i]]++;
    }
    for (int i = 0; i < nums2Size; i++) {
        count2[nums2[i]]++;
    }

    for (int i = 1; i <= 9; i++) {
        if (count1[i] > 0 && count2[i] > 0) {
            return i;
        }
    }

    int min1 = 10, min2 = 10;
    for (int i = 0; i < nums1Size; i++) {
        if (nums1[i] < min1) min1 = nums1[i];
    }
    for (int i = 0; i < nums2Size; i++) {
        if (nums2[i] < min2) min2 = nums2[i];
    }

    if (min1 < min2) {
        return min1 * 10 + min2;
    } else {
        return min2 * 10 + min1;
    }
}