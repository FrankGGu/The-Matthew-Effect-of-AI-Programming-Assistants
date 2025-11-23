#include <stdio.h>
#include <string.h>

#define MAX_MASK 1024

int wonderfulSubstrings(char *word) {
    int count[MAX_MASK] = {0};
    count[0] = 1;
    int mask = 0, result = 0;

    for (int i = 0; word[i]; i++) {
        mask ^= 1 << (word[i] - 'a');
        result += count[mask];

        for (int j = 0; j < 10; j++) {
            result += count[mask ^ (1 << j)];
        }

        count[mask]++;
    }

    return result;
}