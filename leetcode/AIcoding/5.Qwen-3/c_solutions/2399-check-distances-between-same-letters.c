#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkDistances(char *s, int *distance) {
    int len = strlen(s);
    int* seen = (int*)calloc(26, sizeof(int));

    for (int i = 0; i < len; i++) {
        int idx = s[i] - 'a';
        if (seen[idx] == 0) {
            seen[idx] = i + 1;
        } else {
            int dist = i - seen[idx];
            if (dist != distance[idx]) {
                free(seen);
                return false;
            }
        }
    }

    free(seen);
    return true;
}