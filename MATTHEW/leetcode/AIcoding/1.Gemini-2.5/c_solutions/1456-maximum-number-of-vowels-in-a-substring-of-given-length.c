#include <stdbool.h>
#include <string.h>

bool isVowel(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

int maxVowels(char * s, int k){
    int n = strlen(s);
    int currentVowels = 0;
    int maxVowelsCount = 0;

    for (int i = 0; i < k; i++) {
        if (isVowel(s[i])) {
            currentVowels++;
        }
    }
    maxVowelsCount = currentVowels;

    for (int i = k; i < n; i++) {
        if (isVowel(s[i - k])) {
            currentVowels--;
        }
        if (isVowel(s[i])) {
            currentVowels++;
        }
        if (currentVowels > maxVowelsCount) {
            maxVowelsCount = currentVowels;
        }
    }

    return maxVowelsCount;
}