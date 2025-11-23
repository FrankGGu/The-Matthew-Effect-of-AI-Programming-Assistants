#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool areSentencesSimilar(char * sentence1, char * sentence2){
    char *s1 = sentence1;
    char *s2 = sentence2;

    char *words1[101];
    char *words2[101];

    int count1 = 0;
    int count2 = 0;

    char *token1 = strtok(s1, " ");
    while(token1 != NULL){
        words1[count1++] = token1;
        token1 = strtok(NULL, " ");
    }

    char *token2 = strtok(s2, " ");
    while(token2 != NULL){
        words2[count2++] = token2;
        token2 = strtok(NULL, " ");
    }

    int i = 0;
    int j = 0;

    while(i < count1 && j < count2 && strcmp(words1[i], words2[j]) == 0){
        i++;
        j++;
    }

    int x = count1 - 1;
    int y = count2 - 1;

    while(x >= i && y >= j && strcmp(words1[x], words2[y]) == 0){
        x--;
        y--;
    }

    return (i > x || j > y);
}