#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minFlipsMonoIncr(char * s){
    int n = 0;
    while (s[n] != '\0') {
        n++;
    }
    int ones = 0;
    int flips = 0;
    for (int i = 0; i < n; i++) {
        if (s[i] == '1') {
            ones++;
        } else {
            flips++;
        }
        flips = (flips < ones) ? flips : ones;
    }
    return flips;
}