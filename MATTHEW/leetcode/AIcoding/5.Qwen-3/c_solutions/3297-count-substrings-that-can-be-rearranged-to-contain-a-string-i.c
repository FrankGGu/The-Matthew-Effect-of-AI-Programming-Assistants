#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countCompleteSubstrings(char* s, char* substring) {
    int s_len = strlen(s);
    int sub_len = strlen(substring);
    if (sub_len == 0 || s_len < sub_len) return 0;

    int count = 0;
    int freq_sub[26] = {0};
    for (int i = 0; i < sub_len; i++) {
        freq_sub[substring[i] - 'a']++;
    }

    for (int i = 0; i <= s_len - sub_len; i++) {
        int freq_s[26] = {0};
        for (int j = 0; j < sub_len; j++) {
            freq_s[s[i + j] - 'a']++;
        }
        int match = 1;
        for (int k = 0; k < 26; k++) {
            if (freq_s[k] != freq_sub[k]) {
                match = 0;
                break;
            }
        }
        if (match) count++;
    }

    return count;
}