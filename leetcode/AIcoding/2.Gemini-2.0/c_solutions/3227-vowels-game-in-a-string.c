#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef long long ll;

int is_vowel(char c) {
    return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u');
}

ll count_vowels(char *word) {
    int n = strlen(word);
    ll count = 0;
    for (int i = 0; i < n; i++) {
        if (is_vowel(word[i])) {
            count += (ll)(i + 1) * (n - i);
        }
    }
    return count;
}