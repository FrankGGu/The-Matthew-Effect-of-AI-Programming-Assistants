#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* getHint(char* secret, char* guess) {
    int bulls = 0;
    int cows = 0;
    int freq[10] = {0};
    int i;

    for (i = 0; secret[i] != '\0'; i++) {
        if (secret[i] == guess[i]) {
            bulls++;
        } else {
            freq[secret[i] - '0']++;
            freq[guess[i] - '0']--;
        }
    }

    for (i = 0; i < 10; i++) {
        if (freq[i] > 0) {
            cows += freq[i];
        }
    }

    char* result = (char*)malloc(20 * sizeof(char));
    sprintf(result, "%dA%dB", bulls, cows);
    return result;
}