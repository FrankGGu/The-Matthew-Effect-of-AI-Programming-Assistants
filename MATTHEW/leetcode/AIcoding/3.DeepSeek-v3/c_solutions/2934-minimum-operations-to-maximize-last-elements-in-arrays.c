int minOperations(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int n = nums1Size;
    int last1 = nums1[n-1];
    int last2 = nums2[n-1];

    int count1 = 0;
    int count2 = 1;

    int valid1 = 1;
    int valid2 = 1;

    for (int i = 0; i < n-1; i++) {
        if (nums1[i] > last1 || nums2[i] > last2) {
            if (nums1[i] > last2 || nums2[i] > last1) {
                valid1 = 0;
                break;
            }
            count1++;
        }
    }

    for (int i = 0; i < n-1; i++) {
        if (nums1[i] > last2 || nums2[i] > last1) {
            if (nums1[i] > last1 || nums2[i] > last2) {
                valid2 = 0;
                break;
            }
            count2++;
        }
    }

    if (!valid1 && !valid2) return -1;
    if (!valid1) return count2;
    if (!valid2) return count1;

    return count1 < count2 ? count1 : count2;
}