#include <stdbool.h>
#include <string.h>

bool isAcronym(char **words, int wordsSize, char *s) {
    int s_len = strlen(s);

    if (s_len != wordsSize) {
        return false;
    }

    for (int i = 0; i < wordsSize; i++) {
        if (s[i] != words[i][0]) {
            return false;
        }
    }

    return true;
}