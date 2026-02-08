#include <stdbool.h>
#include <string.h>

bool isPrefixOfWord(char *sentence, char *searchWord) {
    int len = strlen(sentence);
    int wordStart = 0, wordLength = 0;

    for (int i = 0; i <= len; i++) {
        if (i == len || sentence[i] == ' ') {
            if (strncmp(&sentence[wordStart], searchWord, strlen(searchWord)) == 0) {
                return true;
            }
            wordStart = i + 1;
        }
    }

    return false;
}