#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maxLengthBetweenEqualCharacters(char * s){
    int first_occurrence[26];
    for (int i = 0; i < 26; i++) {
        first_occurrence[i] = -1;
    }

    int maxLength = -1;
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        int char_idx = s[i] - 'a';
        if (first_occurrence[char_idx] == -1) {
            first_occurrence[char_idx] = i;
        } else {
            maxLength = max(maxLength, i - first_occurrence[char_idx] - 1);
        }
    }

    return maxLength;
}