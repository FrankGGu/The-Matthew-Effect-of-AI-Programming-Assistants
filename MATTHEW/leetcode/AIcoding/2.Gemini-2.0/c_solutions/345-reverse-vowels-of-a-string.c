#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *reverseVowels(char *s) {
    int len = strlen(s);
    int i = 0, j = len - 1;

    while (i < j) {
        bool isVowelI = (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u' ||
                         s[i] == 'A' || s[i] == 'E' || s[i] == 'I' || s[i] == 'O' || s[i] == 'U');
        bool isVowelJ = (s[j] == 'a' || s[j] == 'e' || s[j] == 'i' || s[j] == 'o' || s[j] == 'u' ||
                         s[j] == 'A' || s[j] == 'E' || s[j] == 'I' || s[j] == 'O' || s[j] == 'U');

        if (isVowelI && isVowelJ) {
            char temp = s[i];
            s[i] = s[j];
            s[j] = temp;
            i++;
            j--;
        } else if (!isVowelI) {
            i++;
        } else if (!isVowelJ) {
            j--;
        }
    }

    return s;
}