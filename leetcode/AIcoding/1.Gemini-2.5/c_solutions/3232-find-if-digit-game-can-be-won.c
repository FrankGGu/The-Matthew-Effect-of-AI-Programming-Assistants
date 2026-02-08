#include <stdbool.h>

int sumDigits(int n) {
    int sum = 0;
    if (n == 0) return 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

bool canAliceWin(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int max_sd1 = 0;
    for (int i = 0; i < nums1Size; i++) {
        int current_sd = sumDigits(nums1[i]);
        if (current_sd > max_sd1) {
            max_sd1 = current_sd;
        }
    }

    int max_sd2 = 0;
    for (int i = 0; i < nums2Size; i++) {
        int current_sd = sumDigits(nums2[i]);
        if (current_sd > max_sd2) {
            max_sd2 = current_sd;
        }
    }

    return max_sd1 > max_sd2;
}