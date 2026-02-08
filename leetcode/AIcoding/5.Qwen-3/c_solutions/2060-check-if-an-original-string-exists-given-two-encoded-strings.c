#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canDecode(char *s1, char *s2) {
    int n = strlen(s1), m = strlen(s2);
    if (n != m) return false;

    int i = 0, j = 0;
    while (i < n && j < n) {
        if (s1[i] == s2[j]) {
            i++;
            j++;
        } else {
            if (i > 0 && s1[i - 1] == s2[j]) {
                i--;
                j++;
            } else {
                return false;
            }
        }
    }
    return i == n && j == n;
}

bool possiblyEquals(char *s, char *t) {
    int n = strlen(s), m = strlen(t);
    if (n != m) return false;

    int i = 0, j = 0;
    while (i < n && j < m) {
        if (s[i] == t[j]) {
            i++;
            j++;
        } else if (isdigit(s[i]) && isdigit(t[j])) {
            int num1 = 0, num2 = 0;
            while (i < n && isdigit(s[i])) {
                num1 = num1 * 10 + (s[i++] - '0');
            }
            while (j < m && isdigit(t[j])) {
                num2 = num2 * 10 + (t[j++] - '0');
            }
            if (num1 != num2) return false;
        } else if (isdigit(s[i])) {
            int num = 0;
            while (i < n && isdigit(s[i])) {
                num = num * 10 + (s[i++] - '0');
            }
            j += num;
        } else if (isdigit(t[j])) {
            int num = 0;
            while (j < m && isdigit(t[j])) {
                num = num * 10 + (t[j++] - '0');
            }
            i += num;
        } else {
            return false;
        }
    }
    return i == n && j == m;
}

bool possiblyEqual(char *s, char *t) {
    return possiblyEquals(s, t);
}