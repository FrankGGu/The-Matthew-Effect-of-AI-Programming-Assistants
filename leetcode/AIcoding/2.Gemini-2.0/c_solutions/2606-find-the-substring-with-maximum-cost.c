#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxCostSubstring(char *s, char *chars, int *values, int valuesSize) {
    int cost[26];
    for (int i = 0; i < 26; i++) {
        cost[i] = i + 1;
    }

    for (int i = 0; i < valuesSize; i++) {
        cost[chars[i] - 'a'] = values[i];
    }

    int max_so_far = 0;
    int current_max = 0;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        current_max += cost[s[i] - 'a'];
        if (current_max > max_so_far) {
            max_so_far = current_max;
        }
        if (current_max < 0) {
            current_max = 0;
        }
    }

    return max_so_far;
}