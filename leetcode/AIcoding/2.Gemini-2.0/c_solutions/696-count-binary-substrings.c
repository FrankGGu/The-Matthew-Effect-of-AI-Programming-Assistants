#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countBinarySubstrings(char * s){
    int prevRunLength = 0, currRunLength = 1, ans = 0;
    for (int i = 1; s[i] != '\0'; i++) {
        if (s[i] == s[i-1]) {
            currRunLength++;
        } else {
            ans += (prevRunLength < currRunLength) ? prevRunLength : currRunLength;
            prevRunLength = currRunLength;
            currRunLength = 1;
        }
    }
    ans += (prevRunLength < currRunLength) ? prevRunLength : currRunLength;
    return ans;
}