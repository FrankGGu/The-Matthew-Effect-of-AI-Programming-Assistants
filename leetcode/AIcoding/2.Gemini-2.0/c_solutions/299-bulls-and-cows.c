#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *getHint(char *secret, char *guess) {
    int bulls = 0;
    int cows = 0;
    int secret_counts[10] = {0};
    int guess_counts[10] = {0};
    int n = strlen(secret);

    for (int i = 0; i < n; i++) {
        if (secret[i] == guess[i]) {
            bulls++;
        } else {
            secret_counts[secret[i] - '0']++;
            guess_counts[guess[i] - '0']++;
        }
    }

    for (int i = 0; i < 10; i++) {
        cows += (secret_counts[i] < guess_counts[i]) ? secret_counts[i] : guess_counts[i];
    }

    char *result = (char *)malloc(10 * sizeof(char));
    sprintf(result, "%dA%dB", bulls, cows);

    return result;
}