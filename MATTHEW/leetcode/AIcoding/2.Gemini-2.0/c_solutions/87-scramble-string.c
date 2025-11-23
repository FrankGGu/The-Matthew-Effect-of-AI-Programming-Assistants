#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isScramble(char * s1, char * s2){
    int n = strlen(s1);
    if (n != strlen(s2)) return false;
    if (n == 0) return true;
    if (strcmp(s1, s2) == 0) return true;

    int count[26] = {0};
    for (int i = 0; i < n; i++) {
        count[s1[i] - 'a']++;
        count[s2[i] - 'a']--;
    }
    for (int i = 0; i < 26; i++) {
        if (count[i] != 0) return false;
    }

    for (int i = 1; i < n; i++) {
        if (isScramble(s1, s2 + i) && isScramble(s1 + i, s2)) return true;
        if (isScramble(s1, s2) && isScramble(s1 + i, s2 + i)) return true;
    }

    return false;
}