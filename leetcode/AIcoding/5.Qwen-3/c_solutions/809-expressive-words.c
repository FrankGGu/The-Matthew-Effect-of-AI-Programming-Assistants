#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isStretched(char *s, char *p) {
    int i = 0, j = 0;
    while (i < strlen(s) && j < strlen(p)) {
        if (s[i] != p[j]) return 0;
        char current = s[i];
        int countS = 0, countP = 0;
        while (i < strlen(s) && s[i] == current) { i++; countS++; }
        while (j < strlen(p) && p[j] == current) { j++; countP++; }
        if (countS < countP || (countS > countP && countS < 3)) return 0;
    }
    return i == strlen(s) && j == strlen(p);
}

int expressiveWords(char** words, int wordsSize, char* s) {
    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        if (isStretched(s, words[i])) count++;
    }
    return count;
}