#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxSubsequenceOccurrences(char * s, char * t) {
    int s_len = strlen(s);
    int t_len = strlen(t);

    if (t_len == 0 || s_len < t_len) return 0;

    int count[26] = {0};
    for (int i = 0; i < s_len; i++) {
        count[s[i] - 'a']++;
    }

    int t_count[26] = {0};
    for (int i = 0; i < t_len; i++) {
        t_count[t[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if (t_count[i] > 0 && count[i] < t_count[i]) return 0;
    }

    int result = 0;
    int t_index = 0;
    for (int i = 0; i < s_len; i++) {
        if (s[i] == t[t_index]) {
            t_index++;
            if (t_index == t_len) {
                result++;
                t_index = 0;
            }
        }
    }

    return result;
}