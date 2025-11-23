int bestClosingTime(char *customers) {
    int penalty = 0, minPenalty = 0, bestTime = 0;
    int n = strlen(customers);

    for (int i = 0; i < n; i++) {
        if (customers[i] == 'Y') {
            penalty++;
        } else {
            penalty--;
        }

        if (penalty < minPenalty) {
            minPenalty = penalty;
            bestTime = i + 1;
        }
    }

    return bestTime + (penalty == 0 ? 1 : 0);
}