#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void reverseWords(char *s) {
    int len = strlen(s);
    int start = 0;
    int end = len - 1;

    // Trim leading spaces
    while (start <= end && s[start] == ' ') {
        start++;
    }

    // Trim trailing spaces
    while (end >= start && s[end] == ' ') {
        end--;
    }

    // Compact spaces
    int j = 0;
    for (int i = start; i <= end; i++) {
        if (s[i] != ' ') {
            s[j++] = s[i];
        } else if (i > start && s[i - 1] != ' ') {
            s[j++] = ' ';
        }
    }
    s[j] = '\0';

    len = strlen(s);

    // Reverse the entire string
    for (int i = 0; i < len / 2; i++) {
        char temp = s[i];
        s[i] = s[len - 1 - i];
        s[len - 1 - i] = temp;
    }

    // Reverse each word
    start = 0;
    for (int i = 0; i <= len; i++) {
        if (s[i] == ' ' || s[i] == '\0') {
            int word_end = i - 1;
            while (start < word_end) {
                char temp = s[start];
                s[start] = s[word_end];
                s[word_end] = temp;
                start++;
                word_end--;
            }
            start = i + 1;
        }
    }
}