#include <string.h>

long long countVowels(char * word) {
    long long totalVowels = 0;
    int n = strlen(word);

    for (int i = 0; i < n; i++) {
        char c = word[i];
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
            totalVowels += (long long)(i + 1) * (n - i);
        }
    }

    return totalVowels;
}