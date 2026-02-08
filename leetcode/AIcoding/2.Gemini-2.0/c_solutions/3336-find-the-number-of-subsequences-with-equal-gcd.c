#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

int countDifferentSubsequenceGCDs(int* nums, int numsSize) {
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    char* present = (char*)calloc(max_val + 1, sizeof(char));
    for (int i = 0; i < numsSize; i++) {
        present[nums[i]] = 1;
    }

    int count = 0;
    for (int i = 1; i <= max_val; i++) {
        int current_gcd = 0;
        for (int j = i; j <= max_val; j += i) {
            if (present[j]) {
                if (current_gcd == 0) {
                    current_gcd = j;
                } else {
                    current_gcd = gcd(current_gcd, j);
                }
            }
        }
        if (current_gcd == i) {
            count++;
        }
    }

    free(present);
    return count;
}