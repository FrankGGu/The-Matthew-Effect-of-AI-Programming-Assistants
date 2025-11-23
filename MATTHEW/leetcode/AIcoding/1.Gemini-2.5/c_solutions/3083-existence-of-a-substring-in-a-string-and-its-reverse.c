#include <string.h>
#include <stdbool.h>

bool containsTwoCharSubstring(const char* text, char c1, char c2) {
    int len = strlen(text);
    if (len < 2) {
        return false;
    }
    for (int i = 0; i < len - 1; i++) {
        if (text[i] == c1 && text[i+1] == c2) {
            return true;
        }
    }
    return false;
}

bool isSubstringPresentInBoth(char* s) {
    int n = strlen(s);

    if (n < 2) {
        return false;
    }

    for (int i = 0; i < n - 1; i++) {
        char char_a = s[i];
        char char_b = s[i+1];

        if (containsTwoCharSubstring(s, char_b, char_a)) {
            return true;
        }
    }

    return false;
}