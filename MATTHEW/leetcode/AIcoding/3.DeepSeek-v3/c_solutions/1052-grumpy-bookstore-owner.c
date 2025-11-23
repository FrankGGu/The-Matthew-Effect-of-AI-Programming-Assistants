int maxSatisfied(int* customers, int customersSize, int* grumpy, int grumpySize, int minutes) {
    int base = 0;
    for (int i = 0; i < customersSize; i++) {
        if (grumpy[i] == 0) {
            base += customers[i];
        }
    }

    int maxIncrease = 0;
    int currentIncrease = 0;

    for (int i = 0; i < minutes; i++) {
        if (grumpy[i] == 1) {
            currentIncrease += customers[i];
        }
    }
    maxIncrease = currentIncrease;

    for (int i = minutes; i < customersSize; i++) {
        if (grumpy[i] == 1) {
            currentIncrease += customers[i];
        }
        if (grumpy[i - minutes] == 1) {
            currentIncrease -= customers[i - minutes];
        }
        if (currentIncrease > maxIncrease) {
            maxIncrease = currentIncrease;
        }
    }

    return base + maxIncrease;
}