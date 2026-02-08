#include <stdlib.h>
#include <string.h>

char * freqAlphabets(char * s){
    int n = strlen(s);
    char *result = (char *)malloc(n + 1);
    if (!result) {
        return NULL;
    }

    int res_idx = 0;
    int i = 0;

    while (i < n) {
        if (i + 2 < n && s[i+2] == '#') {
            // This is a two-digit number followed by '#'
            int num = (s[i] - '0') * 10 + (s[i+1] - '0');
            result[res_idx++] = (char)('a' + num - 1);
            i += 3; // Advance past the two digits and '#'
        } else {
            // This is a single-digit number
            int num = s[i] - '0';
            result[res_idx++] = (char)('a' + num - 1);
            i += 1; // Advance past the single digit
        }
    }

    result[res_idx] = '\0'; // Null-terminate the resulting string
    return result;
}