#include <string.h>

char* findMostFrequentVowelAndConsonant(char* s) {
    int vowelCount[26] = {0};
    int consonantCount[26] = {0};

    for (int i = 0; s[i] != '\0'; i++) {
        char c = s[i];
        if (c >= 'A' && c <= 'Z') {
            c = c - 'A' + 'a';
        }
        if (c >= 'a' && c <= 'z') {
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                vowelCount[c - 'a']++;
            } else {
                consonantCount[c - 'a']++;
            }
        }
    }

    char maxVowel = 'a';
    for (char c = 'e'; c <= 'u'; c++) {
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
            if (vowelCount[c - 'a'] > vowelCount[maxVowel - 'a']) {
                maxVowel = c;
            }
        }
    }

    char maxConsonant = 'b';
    for (char c = 'c'; c <= 'z'; c++) {
        if (!(c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u')) {
            if (consonantCount[c - 'a'] > consonantCount[maxConsonant - 'a']) {
                maxConsonant = c;
            }
        }
    }

    if (vowelCount[maxVowel - 'a'] == 0) {
        maxVowel = 'a';
    }
    if (consonantCount[maxConsonant - 'a'] == 0) {
        maxConsonant = 'b';
    }

    static char result[3];
    result[0] = maxVowel;
    result[1] = maxConsonant;
    result[2] = '\0';
    return result;
}