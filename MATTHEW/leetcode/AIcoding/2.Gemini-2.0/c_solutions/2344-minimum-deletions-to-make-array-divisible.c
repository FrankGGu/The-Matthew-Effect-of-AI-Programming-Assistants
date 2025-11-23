#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int minOperations(int* nums, int numsSize, int* numsDivide, int numsDivideSize){
    qsort(nums, numsSize, sizeof(int), cmpfunc);

    int g = numsDivide[0];
    for (int i = 1; i < numsDivideSize; i++) {
        g = gcd(g, numsDivide[i]);
    }

    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (g % nums[i] == 0) {
            return count;
        }
        count++;
    }

    return -1;
}