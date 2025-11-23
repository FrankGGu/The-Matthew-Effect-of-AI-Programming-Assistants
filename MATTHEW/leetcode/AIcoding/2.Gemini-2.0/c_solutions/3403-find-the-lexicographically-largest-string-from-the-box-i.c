#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * greatestLetter(char * s){
    int lower[26] = {0};
    int upper[26] = {0};
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        if (s[i] >= 'a' && s[i] <= 'z') {
            lower[s[i] - 'a'] = 1;
        } else if (s[i] >= 'A' && s[i] <= 'Z') {
            upper[s[i] - 'A'] = 1;
        }
    }
    for (int i = 25; i >= 0; i--) {
        if (lower[i] == 1 && upper[i] == 1) {
            char *res = (char *)malloc(2 * sizeof(char));
            res[0] = (char)('A' + i);
            res[1] = '\0';
            return res;
        }
    }
    return "";
}