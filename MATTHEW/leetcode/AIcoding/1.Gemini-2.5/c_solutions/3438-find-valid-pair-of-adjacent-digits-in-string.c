#include <stdbool.h>
#include <string.h>
#include <ctype.h>

bool findValidPairOfAdjacentDigitsInString(char* s) {
    int n = strlen(s);
    if (n < 2) {
        return false;
    }

    for (int i = 0; i < n - 1; i++) {
        if (isdigit(s[i]) && isdigit(s[i+1])) {
            if (s[i] == s[i+1]) {
                return true;
            }
        }
    }
    return false;
}