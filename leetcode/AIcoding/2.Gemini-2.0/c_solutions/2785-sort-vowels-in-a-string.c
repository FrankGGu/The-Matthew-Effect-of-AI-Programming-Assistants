#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *sortVowels(char *s) {
    int n = strlen(s);
    char vowels[n + 1];
    int vowel_count = 0;
    for (int i = 0; i < n; i++) {
        char c = s[i];
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
            c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U') {
            vowels[vowel_count++] = c;
        }
    }
    vowels[vowel_count] = '\0';

    for (int i = 0; i < vowel_count - 1; i++) {
        for (int j = i + 1; j < vowel_count; j++) {
            if (vowels[i] > vowels[j]) {
                char temp = vowels[i];
                vowels[i] = vowels[j];
                vowels[j] = temp;
            }
        }
    }

    int vowel_index = 0;
    for (int i = 0; i < n; i++) {
        char c = s[i];
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
            c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U') {
            s[i] = vowels[vowel_index++];
        }
    }

    return s;
}