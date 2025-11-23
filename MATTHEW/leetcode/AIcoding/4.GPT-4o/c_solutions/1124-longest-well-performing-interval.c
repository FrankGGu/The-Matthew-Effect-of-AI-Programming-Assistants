int longestWPI(int* hours, int hoursSize) {
    int* prefix = (int*)malloc((hoursSize + 1) * sizeof(int));
    int maxLength = 0;
    int sum = 0;
    for (int i = 0; i < hoursSize; i++) {
        sum += (hours[i] > 8) ? 1 : -1;
        prefix[i + 1] = sum;
    }

    for (int i = 0; i < hoursSize; i++) {
        if (prefix[i + 1] > 0) {
            maxLength = i + 1;
        }
    }

    for (int i = 0; i < hoursSize; i++) {
        for (int j = i + 1; j <= hoursSize; j++) {
            if (prefix[j] - prefix[i] > 0) {
                maxLength = max(maxLength, j - i);
            }
        }
    }

    free(prefix);
    return maxLength;
}