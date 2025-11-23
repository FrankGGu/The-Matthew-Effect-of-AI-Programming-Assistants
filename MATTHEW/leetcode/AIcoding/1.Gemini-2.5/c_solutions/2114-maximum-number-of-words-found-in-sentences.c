#include <string.h>
#include <stdlib.h>

int mostWordsFound(char ** sentences, int sentencesSize){
    int maxWords = 0;
    for (int i = 0; i < sentencesSize; i++) {
        int currentWords = 0;
        char *s = sentences[i];
        for (int j = 0; s[j] != '\0'; j++) {
            if (s[j] == ' ') {
                currentWords++;
            }
        }
        currentWords++; // For the last word
        if (currentWords > maxWords) {
            maxWords = currentWords;
        }
    }
    return maxWords;
}