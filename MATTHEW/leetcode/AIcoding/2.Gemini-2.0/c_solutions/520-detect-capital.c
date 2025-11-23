#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool detectCapitalUse(char * word){
    int n = 0;
    while (word[n] != '\0') {
        n++;
    }

    if (n == 0) return true;

    if (isupper(word[0])) {
        if (n > 1 && isupper(word[1])) {
            for (int i = 2; i < n; i++) {
                if (islower(word[i])) return false;
            }
        } else {
            for (int i = 1; i < n; i++) {
                if (isupper(word[i])) return false;
            }
        }
    } else {
        for (int i = 1; i < n; i++) {
            if (isupper(word[i])) return false;
        }
    }

    return true;
}