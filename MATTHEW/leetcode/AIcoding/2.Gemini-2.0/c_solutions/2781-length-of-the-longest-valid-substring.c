#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxLengthBetweenEqualCharacters(char * s){
    int n = strlen(s);
    int max_len = -1;
    int first_occurrence[26];
    for (int i = 0; i < 26; i++) {
        first_occurrence[i] = -1;
    }

    for (int i = 0; i < n; i++) {
        int char_index = s[i] - 'a';
        if (first_occurrence[char_index] == -1) {
            first_occurrence[char_index] = i;
        } else {
            int len = i - first_occurrence[char_index] - 1;
            if (len > max_len) {
                max_len = len;
            }
        }
    }

    return max_len;
}