#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int canBeTypedWords(char * text, char * brokenLetters){
    int count = 0;
    char *word = strtok(text, " ");
    while (word != NULL) {
        bool canType = true;
        for (int i = 0; i < strlen(word); i++) {
            for (int j = 0; j < strlen(brokenLetters); j++) {
                if (word[i] == brokenLetters[j]) {
                    canType = false;
                    break;
                }
            }
            if (!canType) {
                break;
            }
        }
        if (canType) {
            count++;
        }
        word = strtok(NULL, " ");
    }
    return count;
}