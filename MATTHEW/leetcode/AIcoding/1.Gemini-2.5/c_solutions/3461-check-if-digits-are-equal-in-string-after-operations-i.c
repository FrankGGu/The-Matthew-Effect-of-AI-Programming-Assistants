#include <string.h>
#include <stdbool.h>

bool checkIfDigitsAreEqual(char* s) {
    int n = strlen(s);
    for (int i = 0; i < n; i += 2) {
        int letter_value = s[i] - 'a';
        int digit_value = s[i+1] - '0';

        if (letter_value != digit_value) {
            return false;
        }
    }
    return true;
}