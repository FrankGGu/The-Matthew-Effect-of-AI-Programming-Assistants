#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int size;
} Array;

void zeroArrayTransformationIV(int* nums, int numsSize) {
    int n = numsSize;
    for (int i = 0; i < n; i++) {
        if (nums[i] % 2 == 1) {
            nums[i]++;
        }
    }
    for (int i = 0; i < n; i++) {
        if (nums[i] % 4 == 2) {
            nums[i] += 2;
        }
    }
    for (int i = 0; i < n; i++) {
        if (nums[i] % 8 == 4) {
            nums[i] += 4;
        }
    }
    for (int i = 0; i < n; i++) {
        if (nums[i] % 16 == 8) {
            nums[i] += 8;
        }
    }
    for (int i = 0; i < n; i++) {
        if (nums[i] % 32 == 16) {
            nums[i] += 16;
        }
    }
    for (int i = 0; i < n; i++) {
        if (nums[i] % 64 == 32) {
            nums[i] += 32;
        }
    }
    for (int i = 0; i < n; i++) {
        if (nums[i] % 128 == 64) {
            nums[i] += 64;
        }
    }
    for (int i = 0; i < n; i++) {
        if (nums[i] % 256 == 128) {
            nums[i] += 128;
        }
    }
    for (int i = 0; i < n; i++) {
        if (nums[i] % 512 == 256) {
            nums[i] += 256;
        }
    }
    for (int i = 0; i < n; i++) {
        if (nums[i] % 1024 == 512) {
            nums[i] += 512;
        }
    }
}