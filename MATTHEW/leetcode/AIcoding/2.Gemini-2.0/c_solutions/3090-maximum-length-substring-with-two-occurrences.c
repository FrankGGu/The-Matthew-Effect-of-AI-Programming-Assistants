#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxLengthBetweenEqualCharacters(char * s){
    int len = strlen(s);
    int max_len = -1;
    int first_occurrence[26];
    for (int i = 0; i < 26; i++) {
        first_occurrence[i] = -1;
    }
    for (int i = 0; i < len; i++) {
        int index = s[i] - 'a';
        if (first_occurrence[index] == -1) {
            first_occurrence[index] = i;
        } else {
            int current_len = i - first_occurrence[index] - 1;
            if (current_len > max_len) {
                max_len = current_len;
            }
        }
    }
    return max_len;
}