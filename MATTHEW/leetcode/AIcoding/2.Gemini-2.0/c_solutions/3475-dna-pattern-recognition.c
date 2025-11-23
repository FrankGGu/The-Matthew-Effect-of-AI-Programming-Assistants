#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find_pattern(const char *dna, const char *pattern) {
    int dna_len = strlen(dna);
    int pattern_len = strlen(pattern);
    int count = 0;

    if (pattern_len == 0) {
        return 0;
    }

    for (int i = 0; i <= dna_len - pattern_len; i++) {
        int j;
        for (j = 0; j < pattern_len; j++) {
            if (dna[i + j] != pattern[j]) {
                break;
            }
        }
        if (j == pattern_len) {
            count++;
        }
    }

    return count;
}