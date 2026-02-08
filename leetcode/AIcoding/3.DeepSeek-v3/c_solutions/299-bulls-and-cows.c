char* getHint(char* secret, char* guess) {
    int bulls = 0;
    int cows = 0;
    int secretCount[10] = {0};
    int guessCount[10] = {0};

    for (int i = 0; secret[i] != '\0'; i++) {
        if (secret[i] == guess[i]) {
            bulls++;
        } else {
            secretCount[secret[i] - '0']++;
            guessCount[guess[i] - '0']++;
        }
    }

    for (int i = 0; i < 10; i++) {
        cows += (secretCount[i] < guessCount[i]) ? secretCount[i] : guessCount[i];
    }

    char* result = malloc(15 * sizeof(char));
    sprintf(result, "%dA%dB", bulls, cows);
    return result;
}