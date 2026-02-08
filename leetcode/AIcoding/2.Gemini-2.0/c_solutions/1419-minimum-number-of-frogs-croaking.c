#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minNumberFrogs(char * croakOfFrogs){
    int c = 0, r = 0, o = 0, a = 0, k = 0;
    int frogs = 0, maxFrogs = 0;
    for (int i = 0; croakOfFrogs[i] != '\0'; i++) {
        if (croakOfFrogs[i] == 'c') {
            c++;
            frogs++;
        } else if (croakOfFrogs[i] == 'r') {
            r++;
            c--;
        } else if (croakOfFrogs[i] == 'o') {
            o++;
            r--;
        } else if (croakOfFrogs[i] == 'a') {
            a++;
            o--;
        } else if (croakOfFrogs[i] == 'k') {
            k++;
            a--;
            frogs--;
        }
        if (c < 0 || r < 0 || o < 0 || a < 0 || frogs < 0) return -1;
        maxFrogs = (frogs > maxFrogs) ? frogs : maxFrogs;
    }
    if (c != 0 || r != 0 || o != 0 || a != 0) return -1;
    return maxFrogs;
}