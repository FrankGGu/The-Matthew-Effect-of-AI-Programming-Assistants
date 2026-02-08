double maxAmount(char*** initialRates, int initialRatesSize, int* initialRatesColSize, char*** finalRates, int finalRatesSize, int* finalRatesColSize, char* currency) {
    double graph1[26][26] = {0};
    double graph2[26][26] = {0};

    for (int i = 0; i < initialRatesSize; i++) {
        char from = initialRates[i][0][0];
        char to = initialRates[i][1][0];
        double rate = atof(initialRates[i][2]);
        graph1[from - 'A'][to - 'A'] = rate;
        graph1[to - 'A'][from - 'A'] = 1.0 / rate;
    }

    for (int i = 0; i < finalRatesSize; i++) {
        char from = finalRates[i][0][0];
        char to = finalRates[i][1][0];
        double rate = atof(finalRates[i][2]);
        graph2[from - 'A'][to - 'A'] = rate;
        graph2[to - 'A'][from - 'A'] = 1.0 / rate;
    }

    for (int k = 0; k < 26; k++) {
        for (int i = 0; i < 26; i++) {
            for (int j = 0; j < 26; j++) {
                if (graph1[i][k] > 0 && graph1[k][j] > 0) {
                    if (graph1[i][j] < graph1[i][k] * graph1[k][j]) {
                        graph1[i][j] = graph1[i][k] * graph1[k][j];
                    }
                }
                if (graph2[i][k] > 0 && graph2[k][j] > 0) {
                    if (graph2[i][j] < graph2[i][k] * graph2[k][j]) {
                        graph2[i][j] = graph2[i][k] * graph2[k][j];
                    }
                }
            }
        }
    }

    double maxAmount = 1.0;
    int start = currency[0] - 'A';

    for (int i = 0; i < 26; i++) {
        if (graph1[start][i] > 0) {
            for (int j = 0; j < 26; j++) {
                if (graph2[i][j] > 0 && graph1[j][start] > 0) {
                    double amount = graph1[start][i] * graph2[i][j] * graph1[j][start];
                    if (amount > maxAmount) {
                        maxAmount = amount;
                    }
                }
            }
        }
    }

    return maxAmount;
}