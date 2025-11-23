#include <string.h>
#include <stdlib.h>

int isVowel(char c) {
    return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u');
}

char* findMostFrequentVowelAndConsonant(char* s) {
    int freq[26] = {0};
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        freq[s[i] - 'a']++;
    }

    char mostVowel = 0;
    int maxVowelFreq = -1;

    char mostConsonant = 0;
    int maxConsonantFreq = -1;

    for (int i = 0; i < 26; i++) {
        char currentChar = 'a' + i;
        int currentFreq = freq[i];

        if (isVowel(currentChar)) {
            if (currentFreq > maxVowelFreq) {
                maxVowelFreq = currentFreq;
                mostVowel = currentChar;
            }
        } else {
            if (currentFreq > maxConsonantFreq) {
                maxConsonantFreq = currentFreq;
                mostConsonant = currentChar;
            }
        }
    }

    char* result = (char*)malloc(sizeof(char) * 3);
    if (result == NULL) {
        return NULL;
    }

    result[0] = mostVowel;
    result[1] = mostConsonant;
    result[2] = '\0';

    return result;
}