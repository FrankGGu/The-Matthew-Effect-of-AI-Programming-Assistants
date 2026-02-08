#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findTheLongestSubstring(char *s) {
    int map[256] = {0};
    map['a'] = 1;
    map['e'] = 2;
    map['i'] = 3;
    map['o'] = 4;
    map['u'] = 5;

    int state = 0;
    int max_len = 0;
    int index[32] = {-1};

    for (int i = 0; s[i]; i++) {
        int c = map[s[i]];
        if (c > 0) {
            state ^= (1 << (c - 1));
        }

        if (index[state] == -1 && state != 0) {
            index[state] = i;
        } else {
            max_len = fmax(max_len, i - index[state]);
        }
    }

    return max_len;
}