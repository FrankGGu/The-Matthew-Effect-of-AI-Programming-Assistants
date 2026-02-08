#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int n, char** logs) {
    int depth = 0;
    for (int i = 0; i < n; i++) {
        if (strcmp(logs[i], "../") == 0) {
            if (depth > 0) {
                depth--;
            }
        } else if (strcmp(logs[i], "./") != 0) {
            depth++;
        }
    }
    return depth;
}