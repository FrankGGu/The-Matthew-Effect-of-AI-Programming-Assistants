#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool makeStringsEqual(char * s1, char * s2){
    int n = 0;
    while (s1[n] != '\0') {
        n++;
    }

    bool hasOneS1 = false;
    bool hasOneS2 = false;

    for (int i = 0; i < n; i++) {
        if (s1[i] == '1') {
            hasOneS1 = true;
        }
        if (s2[i] == '1') {
            hasOneS2 = true;
        }
    }

    if (hasOneS1 == hasOneS2) {
        bool diff = false;
        for (int i = 0; i < n; i++) {
            if (s1[i] != s2[i]) {
                diff = true;
                break;
            }
        }
        if (!diff) return true;
        return hasOneS1 && hasOneS2;
    } else {
        return false;
    }
}