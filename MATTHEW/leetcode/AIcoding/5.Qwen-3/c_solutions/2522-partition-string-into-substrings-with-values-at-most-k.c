#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minPartitions(char* s, long long k) {
    int count = 0;
    int n = strlen(s);
    int i = 0;
    while (i < n) {
        int j = i;
        long long val = 0;
        while (j < n && val * 10 + (s[j] - '0') <= k) {
            val = val * 10 + (s[j] - '0');
            j++;
        }
        if (j == i) return -1; // No valid partition
        count++;
        i = j;
    }
    return count;
}