#include <stdbool.h>

bool checkZeroOnes(char *s) {
    int maxOnes = 0;
    int maxZeros = 0;
    int currentOnes = 0;
    int currentZeros = 0;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '1') {
            currentOnes++;
            currentZeros = 0;
        } else {
            currentZeros++;
            currentOnes = 0;
        }
        if (currentOnes > maxOnes) {
            maxOnes = currentOnes;
        }
        if (currentZeros > maxZeros) {
            maxZeros = currentZeros;
        }
    }
    return maxOnes > maxZeros;
}