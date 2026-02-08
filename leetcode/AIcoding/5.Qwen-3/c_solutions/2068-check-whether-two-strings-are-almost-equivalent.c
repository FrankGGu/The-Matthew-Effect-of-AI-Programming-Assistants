#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkAlmostEquivalent(char * word1, char * word2) {
    int count1[26] = {0};
    int count2[26] = {0};
    int i;

    for (i = 0; word1[i] != '\0'; i++) {
        count1[word1[i] - 'a']++;
    }

    for (i = 0; word2[i] != '\0'; i++) {
        count2[word2[i] - 'a']++;
    }

    for (i = 0; i < 26; i++) {
        if (abs(count1[i] - count2[i]) > 3) {
            return false;
        }
    }

    return true;
}