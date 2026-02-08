#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * removeStars(char * s){
    int i = 0, j = 0;
    while (s[i] != '\0') {
        if (s[i] == '*') {
            if (j > 0) {
                j--;
            }
        } else {
            s[j] = s[i];
            j++;
        }
        i++;
    }
    s[j] = '\0';
    return s;
}