#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int mostWordsFound(char** sentences, int sentencesSize) {
    int maxWords = 0;
    for (int i = 0; i < sentencesSize; i++) {
        char* sentence = sentences[i];
        int wordCount = 1;
        for (int j = 0; sentence[j] != '\0'; j++) {
            if (sentence[j] == ' ') {
                wordCount++;
            }
        }
        if (wordCount > maxWords) {
            maxWords = wordCount;
        }
    }
    return maxWords;
}