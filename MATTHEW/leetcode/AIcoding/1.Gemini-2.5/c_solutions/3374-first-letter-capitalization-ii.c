#include <stddef.h> // For NULL

char* capitalizeTitle(char* s) {
    if (s == NULL || *s == '\0') {
        return s;
    }

    int i = 0;
    while (s[i] != '\0') {
        while (s[i] == ' ') {
            i++;
        }

        int wordStart = i;
        int wordEnd = i;
        while (s[wordEnd] != ' ' && s[wordEnd] != '\0') {
            wordEnd++;
        }

        int len = wordEnd - wordStart;

        if (len > 0) {
            if (s[wordStart] >= 'a' && s[wordStart] <= 'z') {
                s[wordStart] = s[wordStart] - 'a' + 'A';
            }

            for (int j = wordStart + 1; j < wordEnd; j++) {
                if (s[j] >= 'A' && s[j] <= 'Z') {
                    s[j] = s[j] - 'A' + 'a';
                }
            }
        }
        i = wordEnd;
    }
    return s;
}