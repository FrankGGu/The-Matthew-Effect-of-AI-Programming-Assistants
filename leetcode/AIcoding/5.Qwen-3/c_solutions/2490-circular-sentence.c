#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isCircularSentence(char *sentence) {
    int len = strlen(sentence);
    if (len == 0) return true;

    char *token = strtok(sentence, " ");
    char *prev = token;

    while (token != NULL) {
        char *next = strtok(NULL, " ");
        if (next == NULL) {
            return prev[strlen(prev) - 1] == sentence[0];
        }
        if (prev[strlen(prev) - 1] != next[0]) {
            return false;
        }
        prev = next;
    }

    return true;
}