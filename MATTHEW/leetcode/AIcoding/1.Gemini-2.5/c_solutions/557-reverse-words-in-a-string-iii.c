#include <string.h>

void reverse(char* start, char* end) {
    while (start < end) {
        char temp = *start;
        *start = *end;
        *end = temp;
        start++;
        end--;
    }
}

char* reverseWords(char* s) {
    int n = strlen(s);
    char* wordStart = s;

    for (int i = 0; i <= n; i++) {
        if (s[i] == ' ' || s[i] == '\0') {
            reverse(wordStart, s + i - 1);
            wordStart = s + i + 1;
        }
    }
    return s;
}