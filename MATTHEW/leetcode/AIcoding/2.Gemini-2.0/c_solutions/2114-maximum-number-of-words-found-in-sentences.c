#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int mostWordsFound(char ** sentences, int sentencesSize){
    int max_words = 0;
    for (int i = 0; i < sentencesSize; i++) {
        int word_count = 0;
        char *sentence = sentences[i];
        int len = strlen(sentence);
        for (int j = 0; j < len; j++) {
            if (sentence[j] == ' ') {
                word_count++;
            }
        }
        max_words = max(max_words, word_count + 1);
    }
    return max_words;
}