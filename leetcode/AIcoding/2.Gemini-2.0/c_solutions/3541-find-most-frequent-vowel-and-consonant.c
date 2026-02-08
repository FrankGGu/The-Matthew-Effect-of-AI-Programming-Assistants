#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char mostFrequentVowelAndConsonant(char *s) {
    int vowel_counts[5] = {0}; // a, e, i, o, u
    int consonant_counts[26] = {0};
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        char c = tolower(s[i]);
        if (c == 'a') vowel_counts[0]++;
        else if (c == 'e') vowel_counts[1]++;
        else if (c == 'i') vowel_counts[2]++;
        else if (c == 'o') vowel_counts[3]++;
        else if (c == 'u') vowel_counts[4]++;
        else if (c >= 'a' && c <= 'z') consonant_counts[c - 'a']++;
    }

    int max_vowel_count = 0;
    char max_vowel = 0;
    for (int i = 0; i < 5; i++) {
        if (vowel_counts[i] > max_vowel_count) {
            max_vowel_count = vowel_counts[i];
            if (i == 0) max_vowel = 'a';
            else if (i == 1) max_vowel = 'e';
            else if (i == 2) max_vowel = 'i';
            else if (i == 3) max_vowel = 'o';
            else max_vowel = 'u';
        }
    }

    int max_consonant_count = 0;
    char max_consonant = 0;
    for (int i = 0; i < 26; i++) {
        if (i == 0 || i == 4 || i == 8 || i == 14 || i == 20) continue; 
        if (consonant_counts[i] > max_consonant_count) {
            max_consonant_count = consonant_counts[i];
            max_consonant = 'a' + i;
        }
    }

    if (max_vowel_count >= max_consonant_count) {
        return max_vowel;
    } else {
        return max_consonant;
    }
}