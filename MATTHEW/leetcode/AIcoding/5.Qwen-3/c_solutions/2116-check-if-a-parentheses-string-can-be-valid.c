#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkIfValid(char* s) {
    int n = strlen(s);
    if (n % 2 != 0) return false;

    int openCount = 0;
    int closeCount = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '(') {
            openCount++;
        } else {
            closeCount++;
        }

        if (closeCount > openCount) return false;
    }

    return openCount == closeCount;
}