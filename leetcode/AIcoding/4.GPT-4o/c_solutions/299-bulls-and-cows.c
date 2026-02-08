char *getHint(char *secret, char *guess) {
    int countA = 0, countB = 0;
    int sCount[10] = {0}, gCount[10] = {0};

    for (int i = 0; secret[i] != '\0'; i++) {
        if (secret[i] == guess[i]) {
            countA++;
        } else {
            sCount[secret[i] - '0']++;
            gCount[guess[i] - '0']++;
        }
    }

    for (int i = 0; i < 10; i++) {
        countB += (sCount[i] < gCount[i]) ? sCount[i] : gCount[i];
    }

    char *result = (char *)malloc(20 * sizeof(char));
    sprintf(result, "%dA%dB", countA, countB);
    return result;
}