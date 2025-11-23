#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    char* key;
    int value;
} Pair;

int compare(const void* a, const void* b) {
    return ((Pair*)a)->value - ((Pair*)b)->value;
}

int maxAmount(char** conversions, int conversionsSize) {
    int i, j;
    int n = conversionsSize;
    Pair* pairs = (Pair*)malloc(n * sizeof(Pair));
    for (i = 0; i < n; i++) {
        pairs[i].key = conversions[i];
        pairs[i].value = 0;
    }

    for (i = 0; i < n; i++) {
        char* s = pairs[i].key;
        int len = 0;
        while (s[len] != '\0') len++;
        if (len == 2) {
            pairs[i].value = 1;
        } else {
            for (j = 0; j < n; j++) {
                if (strcmp(pairs[j].key, s + 1) == 0) {
                    pairs[i].value = pairs[j].value + 1;
                    break;
                }
            }
        }
    }

    qsort(pairs, n, sizeof(Pair), compare);

    int max = 0;
    for (i = 0; i < n; i++) {
        if (pairs[i].value > max) {
            max = pairs[i].value;
        }
    }

    free(pairs);
    return max;
}