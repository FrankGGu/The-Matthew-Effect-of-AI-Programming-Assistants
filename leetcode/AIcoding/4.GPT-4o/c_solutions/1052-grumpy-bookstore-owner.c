int maxSatisfied(int* customers, int customersSize, int* grumpy, int grumpySize, int X) {
    int totalSatisfied = 0, maxGain = 0, currentGain = 0;

    for (int i = 0; i < customersSize; i++) {
        if (grumpy[i] == 0) {
            totalSatisfied += customers[i];
        }
    }

    for (int i = 0; i < X; i++) {
        if (grumpy[i] == 1) {
            currentGain += customers[i];
        }
    }
    maxGain = currentGain;

    for (int i = X; i < customersSize; i++) {
        if (grumpy[i] == 1) {
            currentGain += customers[i];
        }
        if (grumpy[i - X] == 1) {
            currentGain -= customers[i - X];
        }
        if (currentGain > maxGain) {
            maxGain = currentGain;
        }
    }

    return totalSatisfied + maxGain;
}