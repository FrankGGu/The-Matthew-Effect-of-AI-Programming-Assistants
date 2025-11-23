#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool detectCapitalUse(char * word){
    int n = strlen(word);
    if (n == 0) return true;

    bool first_capital = (word[0] >= 'A' && word[0] <= 'Z');
    bool all_capital = true;
    bool all_lower = true;

    for (int i = 1; i < n; i++) {
        if (word[i] >= 'A' && word[i] <= 'Z') {
            all_lower = false;
        } else {
            all_capital = false;
        }
    }

    if (first_capital) {
        return all_capital || all_lower;
    } else {
        return all_lower;
    }
}