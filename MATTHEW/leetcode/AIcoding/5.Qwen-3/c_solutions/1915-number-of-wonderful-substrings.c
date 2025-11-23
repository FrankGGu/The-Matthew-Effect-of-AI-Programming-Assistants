#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countWondrousSubstrings(char* s) {
    int count[1024] = {0};
    count[0] = 1;
    int result = 0;
    int current = 0;
    for (int i = 0; s[i]; ++i) {
        current ^= (1 << (s[i] - 'a'));
        result += count[current];
        for (int j = 0; j < 26; ++j) {
            result += count[current ^ (1 << j)];
        }
        count[current]++;
    }
    return result;
}