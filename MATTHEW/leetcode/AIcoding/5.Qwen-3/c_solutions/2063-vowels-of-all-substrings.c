#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countVowels(char* s) {
    int n = strlen(s);
    int count = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u') {
            count += (n - i) * (i + 1);
        }
    }
    return count;
}