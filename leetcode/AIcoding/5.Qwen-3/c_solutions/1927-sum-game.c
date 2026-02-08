#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumGame(char* first, char* second) {
    int total = 0;
    int len1 = strlen(first);
    int len2 = strlen(second);
    int i;

    for (i = 0; i < len1; i++) {
        if (first[i] == 'x') {
            total += 1;
        } else {
            total -= (first[i] - '0');
        }
    }

    for (i = 0; i < len2; i++) {
        if (second[i] == 'x') {
            total -= 1;
        } else {
            total += (second[i] - '0');
        }
    }

    return total == 0 ? 1 : 0;
}