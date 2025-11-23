int eatenApples(int* apples, int applesSize, int* days, int daysSize) {
    int maxDays = 0;
    for (int i = 0; i < applesSize; i++) {
        if (days[i] > maxDays) maxDays = days[i];
    }

    int* eaten = (int*)calloc(maxDays + 1, sizeof(int));
    int totalEaten = 0;

    for (int i = 0; i < applesSize; i++) {
        if (apples[i] > 0) {
            for (int j = i + 1; j <= i + days[i] && j <= maxDays; j++) {
                if (eaten[j] < apples[i]) {
                    eaten[j]++;
                    totalEaten++;
                    break;
                }
            }
        }
    }

    free(eaten);
    return totalEaten;
}