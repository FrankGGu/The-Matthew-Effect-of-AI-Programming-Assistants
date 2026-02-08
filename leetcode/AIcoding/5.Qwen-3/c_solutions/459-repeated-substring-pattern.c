#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool repeatedSubstringPattern(char *s) {
    int n = strlen(s);
    char *double_s = (char *)malloc(2 * n + 1);
    strcpy(double_s, s);
    strcat(double_s, s);
    return strstr(double_s + 1, s) != NULL;
}