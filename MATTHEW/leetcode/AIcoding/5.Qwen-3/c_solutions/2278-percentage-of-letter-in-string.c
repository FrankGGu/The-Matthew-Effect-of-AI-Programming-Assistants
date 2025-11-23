#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int percentageLetter(char *s, char letter) {
    int count = 0;
    int length = strlen(s);
    for (int i = 0; i < length; i++) {
        if (s[i] == letter) {
            count++;
        }
    }
    return (count * 100) / length;
}