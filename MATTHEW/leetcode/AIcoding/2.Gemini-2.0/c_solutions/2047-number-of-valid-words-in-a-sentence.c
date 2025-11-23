#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isValid(char *word) {
    int hyphenCount = 0;
    int n = strlen(word);
    for (int i = 0; i < n; i++) {
        if (!isalnum(word[i]) && word[i] != '-' && word[i] != '!') {
            return false;
        }
        if (word[i] == '-') {
            hyphenCount++;
            if (hyphenCount > 1) return false;
            if (i == 0 || i == n - 1) return false;
            if (!isalpha(word[i - 1]) || !isalpha(word[i + 1])) return false;
        }
        if (!isalnum(word[i]) && word[i] != '-') {
            if (i != n - 1) return false;
        }
    }
    return true;
}

int countValidWords(char * sentence){
    int count = 0;
    char *token = strtok(sentence, " ");
    while (token != NULL) {
        if (strlen(token) > 0 && isValid(token)) {
            count++;
        }
        token = strtok(NULL, " ");
    }
    return count;
}