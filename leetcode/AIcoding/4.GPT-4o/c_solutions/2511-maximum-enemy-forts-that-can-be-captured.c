int captureForts(int* forts, int fortsSize) {
    int maxCapture = 0, count = 0;

    for (int i = 0; i < fortsSize; i++) {
        if (forts[i] == 1) {
            count = 0;
            for (int j = i + 1; j < fortsSize; j++) {
                if (forts[j] == 0) {
                    count++;
                } else if (forts[j] == -1) {
                    maxCapture = count > maxCapture ? count : maxCapture;
                    break;
                } else {
                    break;
                }
            }
        } else if (forts[i] == -1) {
            count = 0;
            for (int j = i - 1; j >= 0; j--) {
                if (forts[j] == 0) {
                    count++;
                } else if (forts[j] == 1) {
                    maxCapture = count > maxCapture ? count : maxCapture;
                    break;
                } else {
                    break;
                }
            }
        }
    }

    return maxCapture;
}