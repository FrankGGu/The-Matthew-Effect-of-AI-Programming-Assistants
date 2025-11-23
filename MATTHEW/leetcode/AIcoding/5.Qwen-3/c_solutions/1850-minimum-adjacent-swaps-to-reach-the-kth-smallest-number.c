#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(char*)a - *(char*)b);
}

void swap(char *a, char *b) {
    char t = *a;
    *a = *b;
    *b = t;
}

int getRank(char *s, int k) {
    int n = strlen(s);
    int rank = 0;
    for (int i = 0; i < n; i++) {
        int count = 0;
        for (int j = i + 1; j < n; j++) {
            if (s[j] < s[i]) count++;
        }
        int fact = 1;
        for (int j = 1; j < n - i; j++) {
            fact *= j;
        }
        rank += count * fact;
        for (int j = i + 1; j < n; j++) {
            if (s[j] == s[i]) {
                for (int m = j; m > i; m--) {
                    swap(&s[m], &s[m - 1]);
                }
                break;
            }
        }
    }
    return rank;
}

int minAdjacentSwapsToKthSmallest(char *s, int k) {
    int n = strlen(s);
    char *temp = (char*)malloc((n + 1) * sizeof(char));
    strcpy(temp, s);
    qsort(temp, n, sizeof(char), compare);
    int swaps = 0;
    for (int i = 0; i < n; i++) {
        for (int j = i; j < n; j++) {
            if (temp[j] == s[i]) {
                for (int m = j; m > i; m--) {
                    swap(&temp[m], &temp[m - 1]);
                    swaps++;
                }
                break;
            }
        }
    }
    free(temp);
    return swaps;
}