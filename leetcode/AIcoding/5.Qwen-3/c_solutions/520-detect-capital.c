#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool detectCapitalUse(char *word) {
    int n = strlen(word);
    int capitalCount = 0;
    for (int i = 0; i < n; i++) {
        if (word[i] >= 'A' && word[i] <= 'Z') {
            capitalCount++;
        }
    }
    return capitalCount == 0 || capitalCount == n || (capitalCount == 1 && word[0] >= 'A' && word[0] <= 'Z');
}