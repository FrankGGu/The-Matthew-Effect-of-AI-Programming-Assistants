#include <string.h>
#include <stdbool.h>
#include <ctype.h>

int numberOfSpecialChars(char* word) {
    bool seen_lower[26] = {false};
    bool seen_upper[26] = {false};
    int count = 0;

    for (int i = 0; word[i] != '\0'; i++) {
        if (islower(word[i])) {
            seen_lower[word[i] - 'a'] = true;
        } else if (isupper(word[i])) {
            seen_upper[word[i] - 'A'] = true;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (seen_lower[i] && seen_upper[i]) {
            count++;
        }
    }

    return count;
}