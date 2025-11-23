#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ALPHABET_SIZE 26

typedef struct {
    char* substring;
    int count;
} SubstringCount;

int cmp(const void* a, const void* b) {
    return ((SubstringCount*)b)->count - ((SubstringCount*)a)->count;
}

int maxFreq(char* s, char* maxLetters, int minSize, int maxSize) {
    int n = strlen(s);
    int max_count = 0;
    int* count = (int*)calloc(maxSize + 1, sizeof(int));
    SubstringCount* substrings = (SubstringCount*)malloc(sizeof(SubstringCount) * (n - minSize + 1));
    int unique_letters[ALPHABET_SIZE] = {0};

    for (int size = minSize; size <= maxSize; size++) {
        for (int i = 0; i <= n - size; i++) {
            memset(unique_letters, 0, sizeof(unique_letters));
            int unique = 0;
            for (int j = i; j < i + size; j++) {
                if (!unique_letters[s[j] - 'a']) {
                    unique_letters[s[j] - 'a'] = 1;
                    unique++;
                }
            }
            if (unique <= strlen(maxLetters)) {
                substrings[count[size]] = (SubstringCount){.substring = strndup(s + i, size), .count = 0};
                count[size]++;
            }
        }
    }

    for (int size = minSize; size <= maxSize; size++) {
        for (int i = 0; i < count[size]; i++) {
            substrings[i].count++;
        }
    }

    qsort(substrings, count[maxSize], sizeof(SubstringCount), cmp);

    if (count[maxSize] > 0) {
        max_count = substrings[0].count;
    }

    for (int i = 0; i < count[maxSize]; i++) {
        free(substrings[i].substring);
    }
    free(substrings);
    free(count);

    return max_count;
}