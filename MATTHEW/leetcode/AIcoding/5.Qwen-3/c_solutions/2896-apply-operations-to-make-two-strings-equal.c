#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canBeEqual(char * s1, char * s2) {
    int count1[26] = {0};
    int count2[26] = {0};
    int len = strlen(s1);
    for (int i = 0; i < len; i++) {
        count1[s1[i] - 'a']++;
        count2[s2[i] - 'a']++;
    }
    for (int i = 0; i < 26; i++) {
        if (count1[i] != count2[i]) return false;
    }
    return true;
}