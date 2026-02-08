#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <limits.h>

void swap(char *a, char *b) {
    char temp = *a;
    *a = *b;
    *b = temp;
}

void reverse(char *s, int start, int end) {
    while (start < end) {
        swap(&s[start], &s[end]);
        start++;
        end--;
    }
}

int nextGreaterElement(int n) {
    char s[12]; // Max int has 10 digits, plus sign and null terminator. 12 is safe.
    sprintf(s, "%d", n);
    int len = strlen(s);

    int i = len - 2;
    while (i >= 0 && s[i] >= s[i+1]) {
        i--;
    }

    if (i < 0) {
        return -1; // No greater permutation possible
    }

    int j = len - 1;
    while (j > i && s[j] <= s[i]) {
        j--;
    }

    swap(&s[i], &s[j]);
    reverse(s, i + 1, len - 1);

    long long result = atoll(s);

    if (result > INT_MAX) {
        return -1; // Overflow
    }

    return (int)result;
}