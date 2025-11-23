#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestContiguousSegment(char* s) {
    int maxOnes = 0, maxZeros = 0;
    int currentOnes = 0, currentZeros = 0;

    for (int i = 0; i < strlen(s); i++) {
        if (s[i] == '1') {
            currentOnes++;
            currentZeros = 0;
            if (currentOnes > maxOnes) {
                maxOnes = currentOnes;
            }
        } else {
            currentZeros++;
            currentOnes = 0;
            if (currentZeros > maxZeros) {
                maxZeros = currentZeros;
            }
        }
    }

    return maxOnes > maxZeros ? 1 : 0;
}