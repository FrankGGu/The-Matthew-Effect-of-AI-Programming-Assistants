#include <string.h>
#include <stdbool.h>
#include <ctype.h>

bool detectCapitalUse(char * word) {
    int len = strlen(word);

    if (len <= 1) {
        return true;
    }

    // Case 1: First letter is uppercase
    if (isupper(word[0])) {
        // If the second letter is also uppercase, then all subsequent letters must be uppercase.
        if (isupper(word[1])) {
            for (int i = 2; i < len; i++) {
                if (islower(word[i])) {
                    return false;
                }
            }
        }
        // If the second letter is lowercase, then all subsequent letters must be lowercase.
        else { // islower(word[1])
            for (int i = 2; i < len; i++) {
                if (isupper(word[i])) {
                    return false;
                }
            }
        }
    }
    // Case 2: First letter is lowercase
    else { // islower(word[0])
        // All subsequent letters must be lowercase.
        for (int i = 1; i < len; i++) {
            if (isupper(word[i])) {
                return false;
            }
        }
    }

    return true;
}