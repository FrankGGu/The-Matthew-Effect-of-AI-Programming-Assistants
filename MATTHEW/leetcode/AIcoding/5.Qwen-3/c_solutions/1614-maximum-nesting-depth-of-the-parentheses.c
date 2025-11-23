#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDepth(char* s) {
    int max_depth = 0;
    int current_depth = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '(') {
            current_depth++;
            if (current_depth > max_depth) {
                max_depth = current_depth;
            }
        } else if (s[i] == ')') {
            current_depth--;
        }
    }
    return max_depth;
}