#include <string.h>

void swap(char *a, char *b) {
    char temp = *a;
    *a = *b;
    *b = temp;
}

void reverse(char *start, char *end) {
    while (start < end) {
        swap(start, end);
        start++;
        end--;
    }
}

char * reverseStr(char * s, int k) {
    int n = strlen(s);
    for (int i = 0; i < n; i += 2 * k) {
        char *start = s + i;
        char *end = s + i + k - 1;

        if (end >= s + n) {
            end = s + n - 1;
        }

        reverse(start, end);
    }
    return s;
}