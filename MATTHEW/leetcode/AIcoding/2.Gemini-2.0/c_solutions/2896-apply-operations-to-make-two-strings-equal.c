#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(char * s1, char * s2){
    int n = 0;
    while (s1[n] != '\0') {
        n++;
    }
    int count = 0;
    for (int i = 0; i < n - 1; i++) {
        if (s1[i] != s2[i]) {
            if (s1[i + 1] != s2[i + 1]) {
                s1[i] = s2[i];
                s1[i + 1] = s2[i + 1];
                count++;
            }
        }
    }
    int remaining = 0;
    for (int i = 0; i < n; i++) {
        if (s1[i] != s2[i]) {
            remaining++;
        }
    }
    return count + remaining / 2;
}