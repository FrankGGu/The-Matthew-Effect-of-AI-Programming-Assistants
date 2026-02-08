#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool areOccurrencesEqual(char * s){
    int counts[26] = {0};
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        counts[s[i] - 'a']++;
    }
    int firstCount = 0;
    for (int i = 0; i < 26; i++) {
        if (counts[i] > 0) {
            firstCount = counts[i];
            break;
        }
    }
    for (int i = 0; i < 26; i++) {
        if (counts[i] > 0 && counts[i] != firstCount) {
            return false;
        }
    }
    return true;
}