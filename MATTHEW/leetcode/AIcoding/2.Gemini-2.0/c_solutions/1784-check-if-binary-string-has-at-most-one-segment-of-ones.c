#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkOnesSegment(char * s){
    int n = 0;
    while(s[n] != '\0') {
        n++;
    }

    bool foundZero = false;
    for(int i = 0; i < n; i++) {
        if(s[i] == '0') {
            foundZero = true;
        } else if (foundZero && s[i] == '1') {
            return false;
        }
    }
    return true;
}