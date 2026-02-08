#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long countVowels(char * word) {
    long long n = 0;
    while (word[n] != '\0') {
        n++;
    }
    long long ans = 0;
    for (long long i = 0; i < n; i++) {
        if (word[i] == 'a' || word[i] == 'e' || word[i] == 'i' || word[i] == 'o' || word[i] == 'u') {
            ans += (i + 1) * (n - i);
        }
    }
    return ans;
}