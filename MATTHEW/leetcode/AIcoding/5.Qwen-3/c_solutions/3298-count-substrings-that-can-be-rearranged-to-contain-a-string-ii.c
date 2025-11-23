#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countCompleteSubstrings(char* s, char* part) {
    int len_s = strlen(s);
    int len_part = strlen(part);
    int count = 0;

    if (len_part == 0 || len_s < len_part) return 0;

    int part_freq[26] = {0};
    for (int i = 0; i < len_part; i++) {
        part_freq[part[i] - 'a']++;
    }

    for (int i = 0; i <= len_s - len_part; i++) {
        int s_freq[26] = {0};
        int valid = 1;

        for (int j = 0; j < len_part; j++) {
            s_freq[s[i + j] - 'a']++;
        }

        for (int k = 0; k < 26; k++) {
            if (s_freq[k] != part_freq[k]) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            count++;
        }
    }

    return count;
}