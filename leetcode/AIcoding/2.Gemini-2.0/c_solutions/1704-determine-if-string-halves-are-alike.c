#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool halvesAreAlike(char * s){
    int n = strlen(s);
    int a = 0, b = 0;
    for (int i = 0; i < n / 2; i++) {
        char c = tolower(s[i]);
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
            a++;
        }
    }
    for (int i = n / 2; i < n; i++) {
        char c = tolower(s[i]);
        if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
            b++;
        }
    }
    return a == b;
}