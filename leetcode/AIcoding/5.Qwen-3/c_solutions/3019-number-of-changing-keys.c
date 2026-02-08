#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countChanges(char* s) {
    int count = 0;
    for (int i = 1; i < strlen(s); i++) {
        if (s[i] != s[i - 1]) {
            count++;
        }
    }
    return count;
}