#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool rotateString(char *s, char *goal) {
    if (strlen(s) != strlen(goal)) {
        return false;
    }
    char *double_s = (char *)malloc(2 * strlen(s) + 1);
    strcpy(double_s, s);
    strcat(double_s, s);
    if (strstr(double_s, goal) != NULL) {
        free(double_s);
        return true;
    } else {
        free(double_s);
        return false;
    }
}