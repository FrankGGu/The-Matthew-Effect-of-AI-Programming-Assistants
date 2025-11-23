#include <string.h>
#include <stdbool.h>

static bool isVowel(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

int vowelStrings(char **words, int wordsSize, int left, int right) {
    int count = 0;
    for (int i = left; i <= right; i++) {
        char *word = words[i];

        char firstChar = word[0];
        char lastChar = word[strlen(word) - 1];

        if (isVowel(firstChar) && isVowel(lastChar)) {
            count++;
        }
    }
    return count;
}