#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findAnagrams(char * s, char * p, int* returnSize){
    int s_len = strlen(s);
    int p_len = strlen(p);
    if (s_len < p_len) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(sizeof(int) * s_len);
    *returnSize = 0;

    int p_freq[26] = {0};
    int s_freq[26] = {0};

    for (int i = 0; i < p_len; i++) {
        p_freq[p[i] - 'a']++;
        s_freq[s[i] - 'a']++;
    }

    for (int i = 0; i <= s_len - p_len; i++) {
        int match = 1;
        for (int j = 0; j < 26; j++) {
            if (p_freq[j] != s_freq[j]) {
                match = 0;
                break;
            }
        }
        if (match) {
            result[(*returnSize)++] = i;
        }

        if (i < s_len - p_len) {
            s_freq[s[i] - 'a']--;
            s_freq[s[i + p_len] - 'a']++;
        }
    }

    return result;
}