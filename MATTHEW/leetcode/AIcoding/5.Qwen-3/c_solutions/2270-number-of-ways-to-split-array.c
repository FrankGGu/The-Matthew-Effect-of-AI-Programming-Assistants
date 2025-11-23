#include <stdio.h>
#include <stdlib.h>

int numberOfWays(char* s, int n) {
    int total = 0;
    int leftOnes = 0;
    int rightOnes = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '1') {
            rightOnes++;
        }
    }

    for (int i = 0; i < n - 1; i++) {
        if (s[i] == '1') {
            leftOnes++;
            rightOnes--;
        }
        if (s[i] == '0') {
            total += leftOnes * rightOnes;
        }
    }

    return total;
}