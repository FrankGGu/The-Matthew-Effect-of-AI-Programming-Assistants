#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char repeatedCharacter(char * s){
    bool seen[26] = {false};
    for (int i = 0; s[i] != '\0'; i++) {
        int index = s[i] - 'a';
        if (seen[index]) {
            return s[i];
        }
        seen[index] = true;
    }
    return ' ';
}