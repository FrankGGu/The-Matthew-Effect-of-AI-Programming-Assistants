#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canMakeSubsequence(char *source, char *target) {
    int n = strlen(source);
    int m = strlen(target);
    int i = 0, j = 0;

    while (i < n && j < m) {
        char s_char = source[i];
        char t_char = target[j];

        if (s_char == t_char) {
            i++;
            j++;
            continue;
        }

        char next_char = (s_char == 'z') ? 'a' : s_char + 1;
        if (next_char == t_char) {
            i++;
            j++;
        } else {
            i++;
        }
    }

    return j == m;
}