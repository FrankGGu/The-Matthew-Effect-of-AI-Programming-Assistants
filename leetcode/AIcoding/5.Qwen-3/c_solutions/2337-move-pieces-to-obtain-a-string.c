#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canBeEqual(char* target, char* start) {
    int t_len = strlen(target);
    int s_len = strlen(start);
    if (t_len != s_len) return false;

    int t_count[256] = {0};
    int s_count[256] = {0};

    for (int i = 0; i < t_len; i++) {
        t_count[target[i]]++;
        s_count[start[i]]++;
    }

    for (int i = 0; i < 256; i++) {
        if (t_count[i] != s_count[i]) return false;
    }

    return true;
}