#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isStretchy(char *s, char *word) {
    int i = 0, j = 0;
    int n = strlen(s), m = strlen(word);

    while (i < n && j < m) {
        if (s[i] != word[j]) {
            return false;
        }

        int countS = 0, countWord = 0;
        char charS = s[i], charWord = word[j];

        while (i < n && s[i] == charS) {
            countS++;
            i++;
        }

        while (j < m && word[j] == charWord) {
            countWord++;
            j++;
        }

        if (countS < countWord) {
            return false;
        }

        if (countS != countWord && countS < 3) {
            return false;
        }
    }

    return i == n && j == m;
}

int expressiveWords(char *s, char **words, int wordsSize) {
    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        if (isStretchy(s, words[i])) {
            count++;
        }
    }
    return count;
}