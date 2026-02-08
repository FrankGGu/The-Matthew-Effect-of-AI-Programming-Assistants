#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minFlips(char * target) {
    int flips = 0;
    char current = '0';
    for (int i = 0; target[i] != '\0'; i++) {
        if (target[i] != current) {
            flips++;
            current = target[i];
        }
    }
    return flips;
}