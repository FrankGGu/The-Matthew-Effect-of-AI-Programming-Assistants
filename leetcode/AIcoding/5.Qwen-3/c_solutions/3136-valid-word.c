#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isValid(char * word) {
    int n = strlen(word);
    if (n < 3) return false;

    int vowels = 0;
    int consonants = 0;

    for (int i = 0; i < n; i++) {
        char c = tolower(word[i]);
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
            vowels++;
        } else if (c >= 'a' && c <= 'z') {
            consonants++;
        } else {
            return false;
        }
    }

    return vowels >= 1 && consonants >= 1;
}