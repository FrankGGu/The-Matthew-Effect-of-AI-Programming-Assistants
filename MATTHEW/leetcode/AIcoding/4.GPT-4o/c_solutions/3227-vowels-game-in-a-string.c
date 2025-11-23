#include <stdbool.h>
#include <string.h>

bool vowelsGame(char *s) {
    int vowelCount = 0;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u' ||
            s[i] == 'A' || s[i] == 'E' || s[i] == 'I' || s[i] == 'O' || s[i] == 'U') {
            vowelCount++;
        }
    }

    return vowelCount % 2 == 1;
}