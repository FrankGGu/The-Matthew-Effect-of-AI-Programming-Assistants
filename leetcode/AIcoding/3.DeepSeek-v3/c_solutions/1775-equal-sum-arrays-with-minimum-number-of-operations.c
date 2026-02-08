int minOperations(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int sum1 = 0, sum2 = 0;
    for (int i = 0; i < nums1Size; i++) sum1 += nums1[i];
    for (int i = 0; i < nums2Size; i++) sum2 += nums2[i];

    if (sum1 == sum2) return 0;
    if (nums1Size > 6 * nums2Size || nums2Size > 6 * nums1Size) return -1;

    if (sum1 > sum2) {
        int* temp = nums1;
        nums1 = nums2;
        nums2 = temp;
        int tempSize = nums1Size;
        nums1Size = nums2Size;
        nums2Size = tempSize;
        int tempSum = sum1;
        sum1 = sum2;
        sum2 = tempSum;
    }

    int diff = sum2 - sum1;
    int count[6] = {0};
    for (int i = 0; i < nums1Size; i++) count[6 - nums1[i]]++;
    for (int i = 0; i < nums2Size; i++) count[nums2[i] - 1]++;

    int operations = 0;
    for (int i = 5; i >= 1 && diff > 0; i--) {
        while (count[i] > 0 && diff > 0) {
            diff -= i;
            count[i]--;
            operations++;
        }
    }

    return operations;
}