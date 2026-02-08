#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int longestSubsequence(int n, int arr[]) {
    if (n <= 1) return n;

    int inc_len = 1;
    int dec_len = 1;
    int max_len = 1;

    for (int i = 1; i < n; i++) {
        if (arr[i] > arr[i - 1]) {
            inc_len++;
            dec_len = 1;
        } else if (arr[i] < arr[i - 1]) {
            dec_len++;
            inc_len = 1;
        } else {
            inc_len = 1;
            dec_len = 1;
        }

        max_len = max(max_len, max(inc_len, dec_len));
    }

    return max_len;
}