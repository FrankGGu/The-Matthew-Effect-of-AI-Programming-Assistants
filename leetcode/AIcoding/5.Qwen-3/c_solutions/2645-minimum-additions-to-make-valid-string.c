#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minAddToMakeValid(char* s) {
    int left = 0, right = 0;
    for (int i = 0; s[i]; i++) {
        if (s[i] == '(') {
            left++;
        } else if (s[i] == ')') {
            if (left > 0) {
                left--;
            } else {
                right++;
            }
        }
    }
    return left + right;
}