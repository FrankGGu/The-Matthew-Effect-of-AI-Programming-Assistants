#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* getHint(char* secret, char* guess) {
    int bulls = 0;
    int cows = 0;
    int countSecret[10] = {0};
    int countGuess[10] = {0};

    for (int i = 0; i < strlen(secret); i++) {
        if (secret[i] == guess[i]) {
            bulls++;
        } else {
            countSecret[secret[i] - '0']++;
            countGuess[guess[i] - '0']++;
        }
    }

    for (int i = 0; i < 10; i++) {
        cows += fmin(countSecret[i], countGuess[i]);
    }

    char* result = (char*)malloc(20 * sizeof(char));
    sprintf(result, "%dA%dB", bulls, cows);
    return result;
}