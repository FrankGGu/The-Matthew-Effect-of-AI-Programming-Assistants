#include <string.h>
#include <stdbool.h>

bool repeatedSubstringPattern(char * s) {
    int n = strlen(s);
    if (n < 2) {
        return false;
    }

    for (int l = 1; l <= n / 2; l++) {
        if (n % l == 0) {
            bool match = true;
            for (int i = l; i < n; i += l) {
                if (strncmp(s, s + i, l) != 0) {
                    match = false;
                    break;
                }
            }
            if (match) {
                return true;
            }
        }
    }

    return false;
}