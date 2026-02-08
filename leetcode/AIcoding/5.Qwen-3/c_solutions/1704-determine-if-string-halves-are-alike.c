#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isVowel(char c) {
    c = tolower(c);
    return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u');
}

bool halvesAreAlike(char * s) {
    int len = strlen(s);
    int half = len / 2;
    int count1 = 0, count2 = 0;

    for (int i = 0; i < half; i++) {
        if (isVowel(s[i])) count1++;
    }

    for (int i = half; i < len; i++) {
        if (isVowel(s[i])) count2++;
    }

    return count1 == count2;
}