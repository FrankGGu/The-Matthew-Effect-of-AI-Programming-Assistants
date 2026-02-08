#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool arrayStringsAreEqual(char ** word1, int word1Size, char ** word2, int word2Size){
    int len1 = 0;
    for(int i=0; i<word1Size; i++){
        len1 += strlen(word1[i]);
    }
    int len2 = 0;
    for(int i=0; i<word2Size; i++){
        len2 += strlen(word2[i]);
    }

    if(len1 != len2) return false;

    char *str1 = (char*)malloc(sizeof(char)*(len1+1));
    char *str2 = (char*)malloc(sizeof(char)*(len2+1));
    str1[0] = '\0';
    str2[0] = '\0';

    for(int i=0; i<word1Size; i++){
        strcat(str1, word1[i]);
    }
    for(int i=0; i<word2Size; i++){
        strcat(str2, word2[i]);
    }

    bool ans = (strcmp(str1, str2) == 0);
    free(str1);
    free(str2);
    return ans;
}