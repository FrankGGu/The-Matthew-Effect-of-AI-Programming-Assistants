#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int isVowel(char c) {
    c = tolower(c);
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

int compare(const void* a, const void* b) {
    return (*(char*)a - *(char*)b);
}

char* sortVowels(char* s) {
    int n = strlen(s);
    char* vowels = (char*)malloc(n + 1);
    int count = 0;

    for (int i = 0; i < n; i++) {
        if (isVowel(s[i])) {
            vowels[count++] = s[i];
        }
    }

    if (count > 0) {
        qsort(vowels, count, sizeof(char), compare);
    }

    int idx = 0;
    for (int i = 0; i < n; i++) {
        if (isVowel(s[i])) {
            s[i] = vowels[idx++];
        }
    }

    free(vowels);
    return s;
}