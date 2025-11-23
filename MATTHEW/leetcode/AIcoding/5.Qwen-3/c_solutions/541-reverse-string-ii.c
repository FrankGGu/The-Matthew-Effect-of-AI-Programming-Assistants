#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void reverseString(char* s, int start, int end) {
    while (start < end) {
        char temp = s[start];
        s[start] = s[end];
        s[end] = temp;
        start++;
        end--;
    }
}

void reverseStr(char* s, int k) {
    int len = strlen(s);
    int i = 0;
    while (i < len) {
        int end = i + k - 1;
        if (end >= len) {
            end = len - 1;
        }
        reverseString(s, i, end);
        i += k;
    }
}