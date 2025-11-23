#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isIsomorphic(char * s, char * t){
    int s_len = strlen(s);
    int t_len = strlen(t);

    if (s_len != t_len) {
        return false;
    }

    int s_map[256] = {0};
    int t_map[256] = {0};

    for (int i = 0; i < s_len; i++) {
        char s_char = s[i];
        char t_char = t[i];

        if (s_map[s_char] == 0 && t_map[t_char] == 0) {
            s_map[s_char] = t_char;
            t_map[t_char] = s_char;
        } else if (s_map[s_char] != t_char || t_map[t_char] != s_char) {
            return false;
        }
    }

    return true;
}