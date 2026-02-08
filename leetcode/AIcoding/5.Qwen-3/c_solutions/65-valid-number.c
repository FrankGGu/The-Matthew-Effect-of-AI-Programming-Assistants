#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

bool isNumber(char *s) {
    int i = 0, len = strlen(s);
    while (i < len && s[i] == ' ') i++;
    if (i == len) return false;
    if (s[i] == '+' || s[i] == '-') i++;
    bool num = false, exp = false, dot = false;
    while (i < len) {
        if (isdigit(s[i])) {
            num = true;
            i++;
        } else if (s[i] == '.') {
            if (dot || exp) return false;
            dot = true;
            i++;
        } else if (s[i] == 'e' || s[i] == 'E') {
            if (exp || !num) return false;
            exp = true;
            num = false;
            i++;
            if (s[i] == '+' || s[i] == '-') i++;
        } else if (s[i] == ' ') {
            while (i < len && s[i] == ' ') i++;
            break;
        } else {
            return false;
        }
    }
    return num;
}