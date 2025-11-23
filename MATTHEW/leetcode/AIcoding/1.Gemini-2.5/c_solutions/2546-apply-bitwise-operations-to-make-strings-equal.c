#include <stdbool.h>

bool makeStringsEqual(char* s, char* target) {
    int s_ones = 0;
    int target_ones = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '1') {
            s_ones++;
        }
        if (target[i] == '1') {
            target_ones++;
        }
    }

    if (s_ones == 0 && target_ones == 0) {
        return true;
    }

    if (s_ones > 0 && target_ones > 0) {
        return true;
    }

    return false;
}