#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findLUSlength(char * a, char * b){
    int lenA = strlen(a);
    int lenB = strlen(b);

    if (strcmp(a, b) == 0) {
        return -1;
    } else {
        return (lenA > lenB) ? lenA : lenB;
    }
}