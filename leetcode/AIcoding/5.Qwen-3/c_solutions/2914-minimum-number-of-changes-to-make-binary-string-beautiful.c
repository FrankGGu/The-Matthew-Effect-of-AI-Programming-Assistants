#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minChanges(char* s) {
    int n = strlen(s);
    int changes = 0;
    for (int i = 0; i < n; i += 2) {
        if (s[i] != s[i + 1]) {
            changes++;
        }
    }
    return changes;
}