#include <stdbool.h>
#include <string.h>

bool rotateString(char *s, char *goal) {
    if (strlen(s) != strlen(goal)) {
        return false;
    }
    if (strlen(s) == 0) {
        return true;
    }

    char *temp = (char *)malloc(strlen(s) * 2 + 1);
    strcpy(temp, s);
    strcat(temp, s);

    bool result = strstr(temp, goal) != NULL;
    free(temp);
    return result;
}