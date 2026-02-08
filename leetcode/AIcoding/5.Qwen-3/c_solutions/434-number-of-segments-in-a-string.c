#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSegments(char *s) {
    int count = 0;
    int inSegment = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] != ' ') {
            if (!inSegment) {
                count++;
                inSegment = 1;
            }
        } else {
            inSegment = 0;
        }
    }
    return count;
}