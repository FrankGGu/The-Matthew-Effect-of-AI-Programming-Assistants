#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* firstPalindrome(char** words, int wordsSize) {
    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int len = strlen(word);
        int isPalindrome = 1;
        for (int j = 0; j < len / 2; j++) {
            if (word[j] != word[len - 1 - j]) {
                isPalindrome = 0;
                break;
            }
        }
        if (isPalindrome) {
            char* result = (char*)malloc((len + 1) * sizeof(char));
            strcpy(result, word);
            return result;
        }
    }
    return NULL;
}