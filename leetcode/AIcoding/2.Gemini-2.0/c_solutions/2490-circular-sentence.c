#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isCircularSentence(char * sentence){
    int len = strlen(sentence);
    if (len == 0) return true;

    if (sentence[0] != sentence[len - 1]) return false;

    for (int i = 0; i < len - 1; i++) {
        if (sentence[i] == ' ') {
            if (sentence[i - 1] != sentence[i + 1]) return false;
        }
    }

    return true;
}