#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int vowelStrings(char ** words, int wordsSize, int left, int right){
    int count = 0;
    for (int i = left; i <= right; i++) {
        int len = strlen(words[i]);
        char first = words[i][0];
        char last = words[i][len - 1];
        if ((first == 'a' || first == 'e' || first == 'i' || first == 'o' || first == 'u') &&
            (last == 'a' || last == 'e' || last == 'i' || last == 'o' || last == 'u')) {
            count++;
        }
    }
    return count;
}