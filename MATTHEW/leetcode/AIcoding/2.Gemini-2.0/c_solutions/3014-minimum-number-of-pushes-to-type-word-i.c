#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minPushes(char * word) {
    int len = 0;
    while (word[len] != '\0') {
        len++;
    }

    int pushes = 0;
    for (int i = 0; i < len; i++) {
        pushes += (i / 8) + 1;
    }

    return pushes;
}