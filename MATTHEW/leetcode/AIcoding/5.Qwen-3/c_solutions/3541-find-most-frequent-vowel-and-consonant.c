#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* mostFrequentChar(char* s) {
    int vowelCount[26] = {0};
    int consonantCount[26] = {0};
    int i;
    for (i = 0; s[i] != '\0'; i++) {
        char c = tolower(s[i]);
        if (c >= 'a' && c <= 'z') {
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                vowelCount[c - 'a']++;
            } else {
                consonantCount[c - 'a']++;
            }
        }
    }

    char maxVowel = 'a';
    int maxVowelCount = 0;
    for (i = 0; i < 26; i++) {
        if (vowelCount[i] > maxVowelCount) {
            maxVowelCount = vowelCount[i];
            maxVowel = i + 'a';
        }
    }

    char maxConsonant = 'b';
    int maxConsonantCount = 0;
    for (i = 0; i < 26; i++) {
        if (consonantCount[i] > maxConsonantCount) {
            maxConsonantCount = consonantCount[i];
            maxConsonant = i + 'a';
        }
    }

    char* result = (char*)malloc(3 * sizeof(char));
    result[0] = maxVowel;
    result[1] = maxConsonant;
    result[2] = '\0';
    return result;
}