#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int countValidWords(char *sentence) {
    int count = 0;
    char *token = strtok(sentence, " ");
    while (token != NULL) {
        int valid = 1;
        int hyphenCount = 0;
        for (int i = 0; i < strlen(token); i++) {
            if (token[i] == '-') {
                hyphenCount++;
                if (hyphenCount > 1 || i == 0 || i == strlen(token) - 1) {
                    valid = 0;
                    break;
                }
                if (!islower(token[i-1]) || !islower(token[i+1])) {
                    valid = 0;
                    break;
                }
            } else if (!islower(token[i])) {
                valid = 0;
                break;
            }
        }
        if (valid) count++;
        token = strtok(NULL, " ");
    }
    return count;
}