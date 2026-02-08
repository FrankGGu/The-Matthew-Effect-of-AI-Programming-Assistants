#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int prefixSuffixCount(char ** words, int wordsSize) {
    int count = 0;
    for (int i = 0; i < wordsSize; i++) {
        for (int j = i + 1; j < wordsSize; j++) {
            int len = strlen(words[i]);
            if (len > strlen(words[j])) continue;
            int isPrefix = 1;
            int isSuffix = 1;
            for (int k = 0; k < len; k++) {
                if (words[i][k] != words[j][k]) {
                    isPrefix = 0;
                    break;
                }
            }
            for (int k = 0; k < len; k++) {
                if (words[i][k] != words[j][strlen(words[j]) - len + k]) {
                    isSuffix = 0;
                    break;
                }
            }
            if (isPrefix && isSuffix) {
                count++;
            }
        }
    }
    return count;
}