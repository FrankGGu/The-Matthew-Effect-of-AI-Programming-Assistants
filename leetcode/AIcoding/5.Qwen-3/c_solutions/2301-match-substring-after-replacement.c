#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool matchSubstring(char *s, char *sub, char **mapping) {
    int s_len = strlen(s);
    int sub_len = strlen(sub);
    if (sub_len > s_len) return false;

    for (int i = 0; i <= s_len - sub_len; i++) {
        bool match = true;
        for (int j = 0; j < sub_len; j++) {
            char c = s[i + j];
            char m = mapping[c - 'a'];
            if (m != sub[j]) {
                match = false;
                break;
            }
        }
        if (match) return true;
    }
    return false;
}

bool matchReplacement(char *s, char *sub, char **mapping) {
    int s_len = strlen(s);
    int sub_len = strlen(sub);
    if (sub_len > s_len) return false;

    char *map = (char *)malloc(26 * sizeof(char));
    for (int i = 0; i < 26; i++) {
        map[i] = i + 'a';
    }

    for (int i = 0; mapping[i]; i++) {
        char key = mapping[i][0];
        char value = mapping[i][1];
        map[key - 'a'] = value;
    }

    bool result = matchSubstring(s, sub, map);
    free(map);
    return result;
}