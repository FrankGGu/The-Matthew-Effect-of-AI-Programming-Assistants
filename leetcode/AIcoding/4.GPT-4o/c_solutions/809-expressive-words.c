#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int isStretchy(char* s, char* word) {
    int i = 0, j = 0, countS = 0, countW = 0;
    while (s[i] || word[j]) {
        if (s[i] == word[j]) {
            int lenS = 0, lenW = 0;
            while (s[i] == s[i + lenS]) lenS++;
            while (word[j] == word[j + lenW]) lenW++;
            if (lenS < lenW || (lenS < 3 && lenS != lenW)) return 0;
            i += lenS;
            j += lenW;
        } else {
            return 0;
        }
    }
    return 1;
}

int expressiveWords(char* S, char** words, int wordsSize) {
    int result = 0;
    for (int i = 0; i < wordsSize; i++) {
        if (isStretchy(S, words[i])) {
            result++;
        }
    }
    return result;
}