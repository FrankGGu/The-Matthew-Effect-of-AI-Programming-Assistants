#include <stdlib.h> // For qsort
#include <string.h> // For memcpy if copies were needed, but not in this solution

int compareIntegers(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long countPairsForTarget(int* arr2, int arr2Size, long long target) {
    long long ways = 0;
    int left = 0;
    int right = arr2Size - 1;

    while (left < right) {
        long long product = (long long)arr2[left] * arr2[right];
        if (product == target) {
            if (arr2[left] == arr2[right]) {
                long long n = right - left + 1;
                ways += n * (n - 1) / 2;
                break;
            } else {
                long long countLeft = 1;
                while (left + 1 < right && arr2[left + 1] == arr2[left]) {
                    countLeft++;
                    left++;
                }
                long long countRight = 1;
                while (right - 1 > left && arr2[right - 1] == arr2[right]) {
                    countRight++;
                    right--;
                }
                ways += countLeft * countRight;
                left++;
                right--;
            }
        } else if (product < target) {
            left++;
        } else {
            right--;
        }
    }
    return ways;
}

int numberOfWays(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long long totalWays = 0;

    qsort(nums1, nums1Size, sizeof(int), compareIntegers);
    qsort(nums2, nums2Size, sizeof(int), compareIntegers);

    for (int i = 0; i < nums1Size; i++) {
        long long target = (long long)nums1[i] * nums1[i];
        totalWays += countPairsForTarget(nums2, nums2Size, target);
    }

    for (int i = 0; i < nums2Size; i++) {
        long long target = (long long)nums2[i] * nums2[i];
        totalWays += countPairsForTarget(nums1, nums1Size, target);
    }

    return (int)totalWays;
}