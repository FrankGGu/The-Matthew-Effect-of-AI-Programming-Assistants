#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumSubarrayMins(int* arr, int arrSize) {
    long long sum = 0;
    long long mod = 1000000007;
    int left[arrSize], right[arrSize];
    int stack[arrSize], top = -1;

    for (int i = 0; i < arrSize; i++) {
        while (top >= 0 && arr[stack[top]] > arr[i]) {
            top--;
        }
        left[i] = (top == -1) ? (i + 1) : (i - stack[top]);
        stack[++top] = i;
    }

    top = -1;
    for (int i = arrSize - 1; i >= 0; i--) {
        while (top >= 0 && arr[stack[top]] >= arr[i]) {
            top--;
        }
        right[i] = (top == -1) ? (arrSize - i) : (stack[top] - i);
        stack[++top] = i;
    }

    for (int i = 0; i < arrSize; i++) {
        sum = (sum + (long long)arr[i] * left[i] * right[i]) % mod;
    }

    return (int)sum;
}