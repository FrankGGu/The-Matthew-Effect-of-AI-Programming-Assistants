#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumTimeToInitialState(char * word, int k){
    int n = 0;
    while (word[n] != '\0') {
        n++;
    }

    int count = 0;
    int len = n;

    while (len > 0) {
        count++;
        len -= k;

        if (len <= 0) break;

        int i = 0;
        bool match = true;
        for (i = 0; i < len; i++) {
            if (word[i] != word[n - len + i]) {
                match = false;
                break;
            }
        }

        if (match) break;
    }

    return count;
}