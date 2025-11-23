#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void reverse(char *s, int left, int right) {
    while (left < right) {
        char temp = s[left];
        s[left] = s[right];
        s[right] = temp;
        left++;
        right--;
    }
}

char * reverseStr(char * s, int k){
    int len = strlen(s);
    for (int i = 0; i < len; i += 2 * k) {
        if (i + k <= len) {
            reverse(s, i, i + k - 1);
        } else {
            reverse(s, i, len - 1);
        }
    }
    return s;
}