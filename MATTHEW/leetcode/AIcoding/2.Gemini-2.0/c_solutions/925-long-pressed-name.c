#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isLongPressedName(char * name, char * typed){
    int n = strlen(name);
    int m = strlen(typed);
    int i = 0, j = 0;

    while (i < n && j < m) {
        if (name[i] == typed[j]) {
            i++;
            j++;
        } else if (j > 0 && typed[j] == typed[j - 1]) {
            j++;
        } else {
            return false;
        }
    }

    while (j < m) {
        if (typed[j] == typed[j - 1]) {
            j++;
        } else {
            return false;
        }
    }

    return i == n;
}