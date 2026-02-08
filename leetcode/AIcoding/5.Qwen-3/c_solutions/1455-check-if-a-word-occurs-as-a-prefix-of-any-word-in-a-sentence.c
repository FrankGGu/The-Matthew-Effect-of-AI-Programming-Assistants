#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isPrefixOfWord(char* sentence, char* word) {
    int wordLen = strlen(word);
    int sentenceLen = strlen(sentence);
    int i = 0;
    int count = 0;

    while (i < sentenceLen) {
        if (sentence[i] == ' ') {
            count++;
            i++;
            continue;
        }

        int j = 0;
        while (i < sentenceLen && j < wordLen && sentence[i] == word[j]) {
            i++;
            j++;
        }

        if (j == wordLen) {
            return count + 1;
        }

        while (i < sentenceLen && sentence[i] != ' ') {
            i++;
        }

        count++;
        i++;
    }

    return -1;
}