#include <stdbool.h>
#include <string.h>

bool makeEqual(char** words, int wordsSize) {
    if (wordsSize == 1) {
        return true;
    }

    int char_counts[26] = {0};

    for (int i = 0; i < wordsSize; i++) {
        int len = strlen(words[i]);
        for (int j = 0; j < len; j++) {
            char_counts[words[i][j] - 'a']++;
        }
    }

    for (int i = 0; i < 26; i++) {
        if (char_counts[i] % wordsSize != 0) {
            return false;
        }
    }

    return true;
}