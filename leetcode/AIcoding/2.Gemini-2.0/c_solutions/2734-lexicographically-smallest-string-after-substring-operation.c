#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * smallestString(char * s){
    int n = strlen(s);
    int start = -1, end = -1;
    for (int i = 0; i < n; i++) {
        if (s[i] != 'a') {
            start = i;
            break;
        }
    }
    if (start == -1) {
        s[n - 1] = 'z';
        return s;
    }
    end = start;
    while (end < n && s[end] != 'a') {
        end++;
    }
    for (int i = start; i < end; i++) {
        s[i]--;
    }
    return s;
}