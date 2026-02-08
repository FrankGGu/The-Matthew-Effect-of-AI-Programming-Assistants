#include <string.h>

char * replaceQuestionMarks(char * s){
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] == '?') {
            for (char c = 'a'; c <= 'c'; c++) {
                // Check previous character
                if (i > 0 && s[i-1] == c) {
                    continue;
                }
                // Check next character
                // s[i+1] might be '?' or a fixed character.
                // If s[i+1] is '?', it won't conflict with 'c' (since 'c' is a letter).
                // If s[i+1] is a fixed character, it must not be equal to 'c'.
                if (i < n - 1 && s[i+1] == c) {
                    continue;
                }

                // If we reach here, 'c' is a valid replacement
                s[i] = c;
                break; // Found a replacement, move to the next '?'
            }
        }
    }
    return s;
}