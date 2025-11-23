#include <string.h>

char * removeTrailingZeros(char * s){
    int len = strlen(s);
    int i = len - 1;

    while (i >= 0 && s[i] == '0') {
        i--;
    }

    // If i is -1, it means all characters were '0's.
    // However, problem constraints state "s has no leading zeros" and "s is not "0"".
    // So, there will always be at least one non-zero digit.
    // Thus, i will always be >= 0.
    s[i + 1] = '\0';

    return s;
}