#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void reverseWords(char *s) {
    int n = strlen(s);
    int i = 0;
    int j = n - 1;

    // Trim leading spaces
    while (i <= j && s[i] == ' ') {
        i++;
    }

    // Trim trailing spaces
    while (i <= j && s[j] == ' ') {
        j--;
    }

    int len = 0;
    for (int k = i; k <= j; k++) {
        if (s[k] != ' ') {
            s[len++] = s[k];
        } else if (len > 0 && s[len - 1] != ' ') {
            s[len++] = ' ';
        }
    }
    s[len] = '\0';

    // Reverse the entire string
    int start = 0;
    int end = len - 1;
    while (start < end) {
        char temp = s[start];
        s[start] = s[end];
        s[end] = temp;
        start++;
        end--;
    }

    // Reverse each word
    start = 0;
    for (int k = 0; k <= len; k++) {
        if (s[k] == ' ' || s[k] == '\0') {
            end = k - 1;
            while (start < end) {
                char temp = s[start];
                s[start] = s[end];
                s[end] = temp;
                start++;
                end--;
            }
            start = k + 1;
        }
    }
}