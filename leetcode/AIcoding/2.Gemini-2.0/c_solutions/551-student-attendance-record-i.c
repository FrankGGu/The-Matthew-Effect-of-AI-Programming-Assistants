#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkRecord(char * s){
    int absent = 0;
    int late = 0;
    int i = 0;
    while (s[i] != '\0') {
        if (s[i] == 'A') {
            absent++;
            late = 0;
        } else if (s[i] == 'L') {
            late++;
        } else {
            late = 0;
        }
        if (absent > 1 || late > 2) {
            return false;
        }
        i++;
    }
    return true;
}