#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* morseCodes[] = {".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.",
                      "---",".--.","--.-",".-.","...","-","..-","...-",".--","-..","-.","---",".--",
                      "-.--","--.."};

int uniqueMorseRepresentations(char** words, int wordsSize) {
    char* seen[1000];
    int count = 0;

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        char* code = (char*)malloc(100 * sizeof(char));
        code[0] = '\0';

        for (int j = 0; j < strlen(word); j++) {
            char c = word[j];
            int index = c - 'a';
            strcat(code, morseCodes[index]);
        }

        int found = 0;
        for (int k = 0; k < count; k++) {
            if (strcmp(seen[k], code) == 0) {
                found = 1;
                break;
            }
        }

        if (!found) {
            seen[count++] = code;
        } else {
            free(code);
        }
    }

    return count;
}