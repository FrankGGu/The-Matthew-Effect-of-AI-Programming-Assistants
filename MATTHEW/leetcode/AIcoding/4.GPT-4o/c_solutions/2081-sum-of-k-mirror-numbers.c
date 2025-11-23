#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* to_base(int num, int base) {
    char* buf = (char*)malloc(20);
    int i = 0;
    while (num > 0) {
        int rem = num % base;
        buf[i++] = (rem < 10) ? rem + '0' : rem - 10 + 'a';
        num /= base;
    }
    buf[i] = '\0';
    for (int j = 0; j < i / 2; j++) {
        char temp = buf[j];
        buf[j] = buf[i - j - 1];
        buf[i - j - 1] = temp;
    }
    return buf;
}

int is_palindrome(char* s) {
    int len = strlen(s);
    for (int i = 0; i < len / 2; i++) {
        if (s[i] != s[len - i - 1]) return 0;
    }
    return 1;
}

long long kMirror(int k, int n) {
    long long sum = 0;
    int count = 0;
    for (int i = 1; count < n; i++) {
        char* s1 = to_base(i, 10);
        if (is_palindrome(s1)) {
            char* s2 = to_base(i, k);
            if (is_palindrome(s2)) {
                sum += i;
                count++;
            }
            free(s2);
        }
        free(s1);
    }
    return sum;
}

long long kMirror(int k, int n) {
    return kMirror(k, n);
}