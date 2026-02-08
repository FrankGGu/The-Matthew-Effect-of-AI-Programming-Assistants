#include <stdlib.h>

int* findAnagrams(char * s, char * p, int* returnSize) {
    int s_len = 0;
    while (s[s_len] != '\0') {
        s_len++;
    }

    int p_len = 0;
    while (p[p_len] != '\0') {
        p_len++;
    }

    *returnSize = 0;
    if (s_len < p_len) {
        return NULL;
    }

    int p_freq[26] = {0};
    for (int i = 0; i < p_len; i++) {
        p_freq[p[i] - 'a']++;
    }

    int s_freq[26] = {0};
    int* result = (int*)malloc(s_len * sizeof(int)); 
    int match_count = 0;

    for (int i = 0; i < p_len; i++) {
        s_freq[s[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if (p_freq[i] == s_freq[i]) {
            match_count++;
        }
    }

    if (match_count == 26) {
        result[*returnSize] = 0;
        (*returnSize)++;
    }

    for (int i = p_len; i < s_len; i++) {
        int char_out_idx = s[i - p_len] - 'a';
        if (s_freq[char_out_idx] == p_freq[char_out_idx]) {
            match_count--;
        }
        s_freq[char_out_idx]--;
        if (s_freq[char_out_idx] == p_freq[char_out_idx]) {
            match_count++;
        }

        int char_in_idx = s[i] - 'a';
        if (s_freq[char_in_idx] == p_freq[char_in_idx]) {
            match_count--;
        }
        s_freq[char_in_idx]++;
        if (s_freq[char_in_idx] == p_freq[char_in_idx]) {
            match_count++;
        }

        if (match_count == 26) {
            result[*returnSize] = i - p_len + 1;
            (*returnSize)++;
        }
    }

    return result;
}