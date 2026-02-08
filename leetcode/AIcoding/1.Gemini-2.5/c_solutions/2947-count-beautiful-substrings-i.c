#include <string.h>
#include <stdbool.h>

bool isVowel(char c) {
    return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u');
}

int beautifulSubstrings(char * s, int k) {
    int n = strlen(s);
    int count = 0;

    for (int i = 0; i < n; i++) {
        int vowels = 0;
        int consonants = 0;
        for (int j = i; j < n; j++) {
            if (isVowel(s[j])) {
                vowels++;
            } else {
                consonants++;
            }
            if (vowels == consonants && (vowels % k == 0)) {
                count++;
            }
        }
    }
    return count;
}