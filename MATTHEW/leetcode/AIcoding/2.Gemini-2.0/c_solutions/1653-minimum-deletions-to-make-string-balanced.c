#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int minimumDeletions(char * s){
    int n = 0;
    while (s[n] != '\0') {
        n++;
    }

    int b_count = 0;
    int result = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == 'b') {
            b_count++;
        } else {
            result = min(result + 1, b_count);
        }
    }

    return result;
}