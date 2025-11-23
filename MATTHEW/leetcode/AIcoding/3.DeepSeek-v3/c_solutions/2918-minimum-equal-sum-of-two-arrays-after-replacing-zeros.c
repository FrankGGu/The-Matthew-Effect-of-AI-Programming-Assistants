int minSum(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long long sum1 = 0, sum2 = 0;
    int zero1 = 0, zero2 = 0;

    for (int i = 0; i < nums1Size; i++) {
        if (nums1[i] == 0) {
            zero1++;
            sum1 += 1;
        } else {
            sum1 += nums1[i];
        }
    }

    for (int i = 0; i < nums2Size; i++) {
        if (nums2[i] == 0) {
            zero2++;
            sum2 += 1;
        } else {
            sum2 += nums2[i];
        }
    }

    if (sum1 == sum2) {
        return sum1;
    } else if (sum1 > sum2) {
        if (zero2 > 0) {
            return sum1;
        } else {
            return -1;
        }
    } else {
        if (zero1 > 0) {
            return sum2;
        } else {
            return -1;
        }
    }
}