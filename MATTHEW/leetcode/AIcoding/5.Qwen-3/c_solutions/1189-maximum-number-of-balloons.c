#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxNumberOfBalloons(char *text) {
    int count[256] = {0};
    for (int i = 0; text[i]; i++) {
        count[text[i]]++;
    }

    int min = count['b'];
    min = (count['a'] < min) ? count['a'] : min;
    min = (count['l'] / 2 < min) ? count['l'] / 2 : min;
    min = (count['o'] / 2 < min) ? count['o'] / 2 : min;
    min = (count['n'] < min) ? count['n'] : min;

    return min;
}