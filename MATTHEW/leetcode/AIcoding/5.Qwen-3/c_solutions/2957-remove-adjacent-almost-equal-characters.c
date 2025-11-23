#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int removeAlmostEqualCharacters(char* s) {
    int n = strlen(s);
    int count = 0;
    for (int i = 0; i < n - 1; ) {
        if (abs(s[i] - s[i + 1]) <= 1) {
            count++;
            i += 2;
        } else {
            i++;
        }
    }
    return n - count;
}