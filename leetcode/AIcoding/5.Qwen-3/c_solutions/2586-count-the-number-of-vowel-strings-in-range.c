#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countVowelStrings(char** wordList, int wordListSize) {
    int count = 0;
    for (int i = 0; i < wordListSize; i++) {
        char* word = wordList[i];
        if (strlen(word) > 0) {
            char firstChar = tolower(word[0]);
            if (firstChar == 'a' || firstChar == 'e' || firstChar == 'i' || firstChar == 'o' || firstChar == 'u') {
                count++;
            }
        }
    }
    return count;
}