#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

static bool seen[65536];

static int binaryStringToInt(char* s) {
    int val = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        val = (val << 1) | (s[i] - '0');
    }
    return val;
}

static char* intToBinaryString(int val, int n) {
    char* str = (char*)malloc(sizeof(char) * (n + 1));
    str[n] = '\0';
    for (int i = n - 1; i >= 0; i--) {
        str[i] = (val % 2 == 0) ? '0' : '1';
        val /= 2;
    }
    return str;
}

char* findDifferentBinaryString(char** nums, int numsSize) {
    int n = numsSize;

    // Explicitly clear the seen array for each test case
    // (1 << n) calculates 2^n
    for (int i = 0; i < (1 << n); i++) {
        seen[i] = false;
    }

    // Mark all numbers present in nums
    for (int i = 0; i < n; i++) {
        int val = binaryStringToInt(nums[i]);
        seen[val] = true;
    }

    // Find the first number not seen
    for (int i = 0; i < (1 << n); i++) {
        if (!seen[i]) {
            return intToBinaryString(i, n);
        }
    }

    // This part should not be reached as there must always be a unique string
    return NULL; 
}