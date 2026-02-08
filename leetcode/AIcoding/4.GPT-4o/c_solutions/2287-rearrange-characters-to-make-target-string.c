#include <string.h>
#include <stdbool.h>

int rearrangeCharacters(char *s, char *target) {
    int charCount[26] = {0};
    int targetCount[26] = {0};
    int i, result = INT_MAX;

    for (i = 0; s[i] != '\0'; i++) {
        charCount[s[i] - 'a']++;
    }

    for (i = 0; target[i] != '\0'; i++) {
        targetCount[target[i] - 'a']++;
    }

    for (i = 0; i < 26; i++) {
        if (targetCount[i] > 0) {
            result = result < (charCount[i] / targetCount[i]) ? result : (charCount[i] / targetCount[i]);
        }
    }

    return result == INT_MAX ? 0 : result;
}