#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfWays(char * s){
    long long n = strlen(s);
    long long ans = 0;
    long long zerosLeft = 0, onesLeft = 0;
    long long zerosRight = 0, onesRight = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '0') zerosRight++;
        else onesRight++;
    }

    for (int i = 0; i < n; i++) {
        if (s[i] == '0') {
            zerosRight--;
            ans += onesLeft * onesRight;
            zerosLeft++;
        } else {
            onesRight--;
            ans += zerosLeft * zerosRight;
            onesLeft++;
        }
    }

    return (int)ans;
}