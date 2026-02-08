#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isLongPressedName(char *name, char *typed) {
    int i = 0, j = 0;
    int lenName = strlen(name);
    int lenTyped = strlen(typed);

    while (i < lenName && j < lenTyped) {
        if (name[i] != typed[j]) {
            return false;
        }
        char currentChar = name[i];
        int countName = 0, countTyped = 0;
        while (i < lenName && name[i] == currentChar) {
            i++;
            countName++;
        }
        while (j < lenTyped && typed[j] == currentChar) {
            j++;
            countTyped++;
        }
        if (countTyped < countName) {
            return false;
        }
    }

    return i == lenName && j == lenTyped;
}