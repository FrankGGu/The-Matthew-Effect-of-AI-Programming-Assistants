#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findLUSlength(char * a, char * b) {
    if (strcmp(a, b) != 0) {
        return fmax(strlen(a), strlen(b));
    }
    return -1;
}