#include <stdlib.h> // For malloc and free

long long findMaxSubarraySum(int* arr, int n) {
    long long current_max = 0;
    long long global_max = 0;

    for (int i = 0; i < n; i++) {
        current_max += arr[i];
        if (current_max < 0) {
            current_max = 0;
        }
        if (current_max > global_max) {
            global_max = current_max;
        }
    }
    return global_max;
}

long long maximumScore(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long long S1_initial = 0;
    long long S2_initial = 0;

    for (int i = 0; i < nums1Size; i++) {
        S1_initial += nums1[i];
        S2_initial += nums2[i];
    }

    int* diff1 = (int*)malloc(nums1Size * sizeof(int));
    for (int i = 0; i < nums1Size; i++) {
        diff1[i] = nums2[i] - nums1[i];
    }
    long long max_gain1 = findMaxSubarraySum(diff1, nums1Size);
    free(diff1);

    long long score_if_nums1_maximized = S1_initial + max_gain1;

    int* diff2 = (int*)malloc(nums1Size * sizeof(int));
    for (int i = 0; i < nums1Size; i++) {
        diff2[i] = nums1[i] - nums2[i];
    }
    long long max_gain2 = findMaxSubarraySum(diff2, nums1Size);
    free(diff2);

    long long score_if_nums2_maximized = S2_initial + max_gain2;

    return (score_if_nums1_maximized > score_if_nums2_maximized) ? score_if_nums1_maximized : score_if_nums2_maximized;
}