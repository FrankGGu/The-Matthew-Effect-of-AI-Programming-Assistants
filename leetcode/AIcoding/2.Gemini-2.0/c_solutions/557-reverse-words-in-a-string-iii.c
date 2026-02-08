#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void reverse(char *s, int start, int end) {
    while (start < end) {
        char temp = s[start];
        s[start] = s[end];
        s[end] = temp;
        start++;
        end--;
    }
}

char * reverseWords(char * s){
    int len = strlen(s);
    int start = 0;
    for (int i = 0; i <= len; i++) {
        if (s[i] == ' ' || s[i] == '\0') {
            reverse(s, start, i - 1);
            start = i + 1;
        }
    }
    return s;
}