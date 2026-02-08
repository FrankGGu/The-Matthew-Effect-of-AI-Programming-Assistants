#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numGoodPairs(char* s) {
    int count[26] = {0};
    int result = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        int index = s[i] - 'a';
        result += count[index];
        count[index]++;
    }
    return result;
}