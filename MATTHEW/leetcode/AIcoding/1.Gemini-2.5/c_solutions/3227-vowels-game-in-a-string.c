#include <stdbool.h>
#include <string.h>

bool isVowel(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

bool canAliceWin(char* s) {
    int vowelCount = 0;
    int len = strlen(s);
    for (int i = 0; i < len; i++) {
        if (isVowel(s[i])) {
            vowelCount++;
        }
    }
    return (vowelCount % 2 != 0);
}