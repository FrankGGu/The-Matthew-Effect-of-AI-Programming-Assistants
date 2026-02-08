#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

bool isVowel(char c) {
    return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
            c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U');
}

int compareChars(const void *a, const void *b) {
    return (*(char*)a - *(char*)b);
}

char* sortVowels(char* s) {
    int n = strlen(s);

    char* vowels = (char*)malloc(sizeof(char) * (n + 1)); 
    if (vowels == NULL) {
        return NULL;
    }
    int vowelCount = 0;

    for (int i = 0; i < n; i++) {
        if (isVowel(s[i])) {
            vowels[vowelCount++] = s[i];
        }
    }

    qsort(vowels, vowelCount, sizeof(char), compareChars);

    char* result = (char*)malloc(sizeof(char) * (n + 1));
    if (result == NULL) {
        free(vowels);
        return NULL;
    }

    int currentVowelIdx = 0;
    for (int i = 0; i < n; i++) {
        if (isVowel(s[i])) {
            result[i] = vowels[currentVowelIdx++];
        } else {
            result[i] = s[i];
        }
    }
    result[n] = '\0';

    free(vowels);

    return result;
}