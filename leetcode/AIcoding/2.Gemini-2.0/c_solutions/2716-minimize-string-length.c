#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimizedStringLength(char * s){
    bool seen[26] = {false};
    int count = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (!seen[s[i] - 'a']) {
            seen[s[i] - 'a'] = true;
            count++;
        }
    }
    return count;
}