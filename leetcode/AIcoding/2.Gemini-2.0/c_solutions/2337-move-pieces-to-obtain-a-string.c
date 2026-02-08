#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canChange(char * start, char * target){
    int i = 0, j = 0;
    while (i < strlen(start) && j < strlen(target)) {
        while (i < strlen(start) && start[i] == '_') {
            i++;
        }
        while (j < strlen(target) && target[j] == '_') {
            j++;
        }
        if (i < strlen(start) && j < strlen(target)) {
            if (start[i] != target[j]) {
                return false;
            }
            if (start[i] == 'L' && i < j) {
                return false;
            }
            if (start[i] == 'R' && i > j) {
                return false;
            }
            i++;
            j++;
        }
    }
    while (i < strlen(start) && start[i] == '_') {
        i++;
    }
    while (j < strlen(target) && target[j] == '_') {
        j++;
    }
    return i == strlen(start) && j == strlen(target);
}