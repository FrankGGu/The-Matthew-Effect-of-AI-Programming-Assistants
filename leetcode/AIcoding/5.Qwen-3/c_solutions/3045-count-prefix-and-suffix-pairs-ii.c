#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *str;
    int count;
} Pair;

int compare(const void *a, const void *b) {
    return strcmp(((Pair *)a)->str, ((Pair *)b)->str);
}

long long countPrefixSuffixPairs(int n, char **strs) {
    int size = 0;
    Pair *pairs = (Pair *)malloc(n * sizeof(Pair));
    for (int i = 0; i < n; i++) {
        pairs[size].str = strs[i];
        pairs[size++].count = 1;
    }

    qsort(pairs, size, sizeof(Pair), compare);

    long long result = 0;
    for (int i = 0; i < size; i++) {
        for (int j = i + 1; j < size; j++) {
            if (strncmp(pairs[i].str, pairs[j].str, strlen(pairs[i].str)) == 0) {
                result += pairs[i].count;
            }
        }
    }

    free(pairs);
    return result;
}