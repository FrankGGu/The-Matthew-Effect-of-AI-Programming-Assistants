#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findAnagrams(char* s, char* p, int* returnSize) {
    int s_len = strlen(s);
    int p_len = strlen(p);
    if (p_len > s_len) {
        *returnSize = 0;
        return NULL;
    }

    int count[26] = {0};
    for (int i = 0; i < p_len; i++) {
        count[p[i] - 'a']++;
    }

    int window[26] = {0};
    for (int i = 0; i < p_len; i++) {
        window[s[i] - 'a']++;
    }

    int* result = (int*)malloc(sizeof(int) * (s_len - p_len + 1));
    int index = 0;

    if (memcmp(count, window, sizeof(count)) == 0) {
        result[index++] = 0;
    }

    for (int i = p_len; i < s_len; i++) {
        window[s[i - p_len] - 'a']--;
        window[s[i] - 'a']++;

        if (memcmp(count, window, sizeof(count)) == 0) {
            result[index++] = i - p_len + 1;
        }
    }

    *returnSize = index;
    return result;
}