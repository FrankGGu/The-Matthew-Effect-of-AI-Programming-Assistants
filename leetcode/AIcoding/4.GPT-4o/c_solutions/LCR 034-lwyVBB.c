#include <stdbool.h>
#include <string.h>

bool isAlienSorted(char **words, int wordsSize, char *order) {
    int orderMap[26];
    for (int i = 0; i < 26; i++) {
        orderMap[order[i] - 'a'] = i;
    }

    for (int i = 1; i < wordsSize; i++) {
        int j = 0;
        while (j < strlen(words[i - 1]) && j < strlen(words[i]) && words[i - 1][j] == words[i][j]) {
            j++;
        }
        if (j < strlen(words[i - 1]) && (j == strlen(words[i]) || orderMap[words[i - 1][j] - 'a'] > orderMap[words[i][j] - 'a'])) {
            return false;
        }
    }
    return true;
}