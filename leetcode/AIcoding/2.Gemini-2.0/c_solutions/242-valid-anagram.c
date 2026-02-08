#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isAnagram(char * s, char * t){
    int s_len = strlen(s);
    int t_len = strlen(t);

    if (s_len != t_len) {
        return false;
    }

    int char_counts[26] = {0};

    for (int i = 0; i < s_len; i++) {
        char_counts[s[i] - 'a']++;
    }

    for (int i = 0; i < t_len; i++) {
        char_counts[t[i] - 'a']--;
    }

    for (int i = 0; i < 26; i++) {
        if (char_counts[i] != 0) {
            return false;
        }
    }

    return true;
}