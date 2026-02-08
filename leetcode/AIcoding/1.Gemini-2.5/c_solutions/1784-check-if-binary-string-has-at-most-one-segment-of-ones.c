#include <stdbool.h>

bool checkOnesSegment(char * s) {
    bool foundZero = false;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '0') {
            foundZero = true;
        } else {
            if (foundZero) {
                return false;
            }
        }
    }
    return true;
}