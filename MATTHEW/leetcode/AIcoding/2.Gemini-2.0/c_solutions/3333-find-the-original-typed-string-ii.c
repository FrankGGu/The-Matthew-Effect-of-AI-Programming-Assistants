#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isLongPressedName(char * name, char * typed) {
    int i = 0, j = 0;
    while (i < strlen(name) && j < strlen(typed)) {
        if (name[i] == typed[j]) {
            i++;
            j++;
        } else if (j > 0 && typed[j] == typed[j - 1]) {
            j++;
        } else {
            return 0;
        }
    }
    while (j < strlen(typed) && typed[j] == typed[j - 1]) {
        j++;
    }
    return i == strlen(name) && j == strlen(typed);
}