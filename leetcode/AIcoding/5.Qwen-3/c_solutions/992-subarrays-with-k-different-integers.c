#include <stdio.h>
#include <stdlib.h>

int subarraysWithKDifferentIntegers(int* A, int ASize, int K) {
    int count[20001] = {0};
    int unique = 0;
    int left = 0;
    int result = 0;

    for (int right = 0; right < ASize; right++) {
        if (count[A[right]]++ == 0) {
            unique++;
        }

        while (unique > K) {
            if (--count[A[left]] == 0) {
                unique--;
            }
            left++;
        }

        int temp = left;
        while (unique == K) {
            result++;
            if (count[A[temp]]-- == 1) {
                unique--;
            }
            temp++;
        }

        while (temp > left) {
            count[A[--temp]]++;
        }
    }

    return result;
}