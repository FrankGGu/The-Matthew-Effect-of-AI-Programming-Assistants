#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSub(char * s){
    int count = 0;
    int res = 0;
    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '1') {
            count++;
        } else {
            res += (count * (count + 1)) / 2;
            count = 0;
        }
    }
    res += (count * (count + 1)) / 2;
    return res;
}