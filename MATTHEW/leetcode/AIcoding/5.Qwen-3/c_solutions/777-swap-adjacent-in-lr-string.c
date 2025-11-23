#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canTransform(char* s, char* t) {
    int i = 0, j = 0;
    int len = strlen(s);
    while (i < len && j < len) {
        while (i < len && s[i] == 'X') i++;
        while (j < len && t[j] == 'X') j++;
        if (i < len && j < len) {
            if (s[i] != t[j]) return false;
            if (s[i] == 'L' && i < j) return false;
            if (s[i] == 'R' && i > j) return false;
            i++;
            j++;
        } else {
            break;
        }
    }
    while (i < len && s[i] == 'X') i++;
    while (j < len && t[j] == 'X') j++;
    return i == len && j == len;
}