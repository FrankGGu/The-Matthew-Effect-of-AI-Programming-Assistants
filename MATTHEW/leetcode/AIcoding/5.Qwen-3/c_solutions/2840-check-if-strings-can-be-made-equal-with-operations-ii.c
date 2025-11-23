#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canBeEqual(char* s, char* t) {
    int len = strlen(s);
    if (len != strlen(t)) return false;

    int countS[26] = {0};
    int countT[26] = {0};

    for (int i = 0; i < len; i++) {
        countS[s[i] - 'a']++;
        countT[t[i] - 'a']++;
    }

    for (int i = 0; i < 26; i++) {
        if (countS[i] != countT[i]) return false;
    }

    return true;
}