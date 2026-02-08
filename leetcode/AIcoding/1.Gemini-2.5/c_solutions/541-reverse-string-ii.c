#include <string.h>
#include <stdlib.h>

void swap(char *a, char *b) {
    char temp = *a;
    *a = *b;
    *b = temp;
}

char* reverseStr(char* s, int k) {
    int n = strlen(s);
    for (int i = 0; i < n; i += 2 * k) {
        int left = i;
        int right = (i + k - 1 < n) ? (i + k - 1) : (n - 1);
        while (left < right) {
            swap(&s[left], &s[right]);
            left++;
            right--;
        }
    }
    return s;
}