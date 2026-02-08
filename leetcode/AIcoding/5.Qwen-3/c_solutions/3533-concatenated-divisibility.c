#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countDivisibleSubstrings(int* words, int wordsSize) {
    int result = 0;
    for (int i = 0; i < wordsSize; i++) {
        char s1[10];
        sprintf(s1, "%d", words[i]);
        for (int j = i + 1; j < wordsSize; j++) {
            char s2[10];
            sprintf(s2, "%d", words[j]);
            char combined[20];
            strcpy(combined, s1);
            strcat(combined, s2);
            int num = atoi(combined);
            if (num % 3 == 0) {
                result++;
            }
        }
    }
    return result;
}