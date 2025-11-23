#include <stdbool.h>
#include <string.h>
#include <ctype.h>

bool isValid(char *word) {
    int len = strlen(word);

    if (len < 3) {
        return false;
    }

    bool hasVowel = false;
    bool hasConsonant = false;

    for (int i = 0; i < len; i++) {
        char c = word[i];

        if (!isalnum(c)) {
            return false;
        }

        if (isalpha(c)) {
            char lower_c = tolower(c);
            if (lower_c == 'a' || lower_c == 'e' || lower_c == 'i' || lower_c == 'o' || lower_c == 'u') {
                hasVowel = true;
            } else {
                hasConsonant = true;
            }
        }
    }

    return hasVowel && hasConsonant;
}