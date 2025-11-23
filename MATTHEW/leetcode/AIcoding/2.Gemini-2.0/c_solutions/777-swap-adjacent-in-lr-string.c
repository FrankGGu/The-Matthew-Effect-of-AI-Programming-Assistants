#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canTransform(char * start, char * end){
    int n = strlen(start);
    int i = 0, j = 0;
    while (i < n && j < n) {
        while (i < n && start[i] == 'X') {
            i++;
        }
        while (j < n && end[j] == 'X') {
            j++;
        }
        if (i < n && j < n) {
            if (start[i] != end[j]) {
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
    while (i < n) {
        if (start[i] != 'X') {
            return false;
        }
        i++;
    }
    while (j < n) {
        if (end[j] != 'X') {
            return false;
        }
        j++;
    }
    return true;
}