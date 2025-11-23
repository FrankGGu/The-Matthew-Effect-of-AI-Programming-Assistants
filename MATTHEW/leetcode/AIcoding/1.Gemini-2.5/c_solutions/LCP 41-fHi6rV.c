#include <stdbool.h>
#include <string.h>

bool canWin(char* s) {
    int n = strlen(s);
    if (n < 2) {
        return false;
    }

    for (int i = 0; i < n - 1; ++i) {
        if (s[i] == '+' && s[i+1] == '+') {
            s[i] = '-';
            s[i+1] = '-';

            if (!canWin(s)) {
                s[i] = '+';
                s[i+1] = '+';
                return true;
            }

            s[i] = '+';
            s[i+1] = '+';
        }
    }

    return false;
}