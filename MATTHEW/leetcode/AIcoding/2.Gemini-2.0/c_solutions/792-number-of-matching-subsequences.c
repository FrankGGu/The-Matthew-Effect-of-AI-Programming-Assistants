#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numMatchingSubsequences(char *s, char **words, int wordsSize) {
    int count = 0;
    int s_len = strlen(s);

    for (int i = 0; i < wordsSize; i++) {
        char *word = words[i];
        int word_len = strlen(word);
        int s_index = 0;
        int word_index = 0;

        while (s_index < s_len && word_index < word_len) {
            if (s[s_index] == word[word_index]) {
                word_index++;
            }
            s_index++;
        }

        if (word_index == word_len) {
            count++;
        }
    }

    return count;
}