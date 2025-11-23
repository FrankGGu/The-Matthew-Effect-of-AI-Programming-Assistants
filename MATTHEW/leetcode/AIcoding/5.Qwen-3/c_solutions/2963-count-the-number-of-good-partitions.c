#include <stdio.h>
#include <stdlib.h>

int countGoodPartitions(char* s) {
    int n = 0;
    while (s[n] != '\0') n++;

    int last[26];
    for (int i = 0; i < 26; i++) last[i] = -1;

    for (int i = 0; i < n; i++) {
        last[s[i] - 'a'] = i;
    }

    int res = 0;
    int start = 0;
    int end = 0;

    for (int i = 0; i < n; i++) {
        end = (end > last[s[i] - 'a']) ? end : last[s[i] - 'a'];
        if (i == end) {
            res++;
        }
    }

    return res;
}