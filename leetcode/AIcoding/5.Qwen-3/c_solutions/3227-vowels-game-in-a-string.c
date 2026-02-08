#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isVowel(char c) {
    c = tolower(c);
    return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u');
}

int vowelGame(char* s) {
    int count = 0;
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (isVowel(s[i])) {
            count++;
        }
    }
    return count % 2 == 0 ? 0 : 1;
}