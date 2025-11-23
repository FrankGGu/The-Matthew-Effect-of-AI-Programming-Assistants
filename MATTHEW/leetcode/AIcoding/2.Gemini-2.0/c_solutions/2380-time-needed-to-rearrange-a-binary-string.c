#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int secondsToRemoveOccurrences(char * s){
    int count = 0;
    int len = strlen(s);
    int changed = 1;
    while(changed) {
        changed = 0;
        for(int i = 0; i < len - 1; i++) {
            if(s[i] == '0' && s[i+1] == '1') {
                s[i] = '1';
                s[i+1] = '0';
                i++;
                changed = 1;
            }
        }
        if(changed) {
            count++;
        }
    }
    return count;
}