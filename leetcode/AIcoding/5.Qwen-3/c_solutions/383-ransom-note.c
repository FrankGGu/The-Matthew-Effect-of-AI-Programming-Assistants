#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canConstruct(char *ransomNote, char *magazine) {
    int count[26] = {0};
    int i;

    for (i = 0; ransomNote[i] != '\0'; i++) {
        count[ransomNote[i] - 'a']++;
    }

    for (i = 0; magazine[i] != '\0'; i++) {
        if (count[magazine[i] - 'a'] > 0) {
            count[magazine[i] - 'a']--;
        }
    }

    for (i = 0; i < 26; i++) {
        if (count[i] > 0) {
            return false;
        }
    }

    return true;
}