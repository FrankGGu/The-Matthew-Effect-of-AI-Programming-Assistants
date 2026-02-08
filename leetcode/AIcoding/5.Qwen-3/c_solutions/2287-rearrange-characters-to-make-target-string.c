#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char ch;
    int count;
} CharCount;

int compare(const void *a, const void *b) {
    return ((CharCount *)b)->count - ((CharCount *)a)->count;
}

int rearrangeCharacters(char *s, char *target) {
    int s_len = strlen(s);
    int target_len = strlen(target);

    if (target_len == 0 || s_len < target_len) return 0;

    int *char_freq = (int *)calloc(26, sizeof(int));
    int *target_freq = (int *)calloc(26, sizeof(int));

    for (int i = 0; i < s_len; i++) {
        char c = s[i];
        if (c >= 'a' && c <= 'z') {
            char_freq[c - 'a']++;
        }
    }

    for (int i = 0; i < target_len; i++) {
        char c = target[i];
        if (c >= 'a' && c <= 'z') {
            target_freq[c - 'a']++;
        }
    }

    int min_ratio = INT_MAX;
    for (int i = 0; i < 26; i++) {
        if (target_freq[i] > 0) {
            int ratio = char_freq[i] / target_freq[i];
            if (ratio < min_ratio) {
                min_ratio = ratio;
            }
        }
    }

    free(char_freq);
    free(target_freq);

    return min_ratio;
}