#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * lastSubstring(char * s){
    int n = strlen(s);
    int j = 1, i = 0, k = 0;
    while (j + k < n) {
        if (s[i + k] == s[j + k]) {
            k++;
        } else if (s[i + k] > s[j + k]) {
            j = j + k + 1;
            k = 0;
        } else {
            i = i + k + 1;
            if (i >= j) {
                j = i + 1;
            }
            k = 0;
        }
    }
    return s + i;
}