#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *key;
    int count;
} Pair;

int compare(const void *a, const void *b) {
    return strcmp(((Pair *)a)->key, ((Pair *)b)->key);
}

int getLength(char *s) {
    int len = 0;
    while (s[len]) len++;
    return len;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int countOccurrences(char *s, char *sub) {
    int count = 0;
    int subLen = getLength(sub);
    int sLen = getLength(s);
    for (int i = 0; i <= sLen - subLen; i++) {
        int match = 1;
        for (int j = 0; j < subLen; j++) {
            if (s[i + j] != sub[j]) {
                match = 0;
                break;
            }
        }
        if (match) count++;
    }
    return count;
}

int findLongestSpecialSubstring(char *s) {
    int n = getLength(s);
    Pair *substrings = (Pair *)malloc(n * n * sizeof(Pair));
    int size = 0;

    for (int l = 1; l <= n; l++) {
        for (int i = 0; i <= n - l; i++) {
            char *sub = (char *)malloc(l + 1);
            strncpy(sub, s + i, l);
            sub[l] = '\0';
            substrings[size].key = sub;
            substrings[size].count = 0;
            size++;
        }
    }

    for (int i = 0; i < size; i++) {
        substrings[i].count = countOccurrences(s, substrings[i].key);
    }

    qsort(substrings, size, sizeof(Pair), compare);

    int maxLen = -1;
    for (int i = 0; i < size; i++) {
        if (substrings[i].count >= 3) {
            int len = getLength(substrings[i].key);
            maxLen = max(maxLen, len);
        }
    }

    for (int i = 0; i < size; i++) {
        free(substrings[i].key);
    }
    free(substrings);

    return maxLen;
}