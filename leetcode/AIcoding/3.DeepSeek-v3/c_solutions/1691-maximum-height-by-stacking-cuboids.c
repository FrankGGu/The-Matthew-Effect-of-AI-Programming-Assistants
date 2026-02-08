int maxHeight(int** cuboids, int cuboidsSize, int* cuboidsColSize) {
    for (int i = 0; i < cuboidsSize; i++) {
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < 3 - j - 1; k++) {
                if (cuboids[i][k] > cuboids[i][k + 1]) {
                    int temp = cuboids[i][k];
                    cuboids[i][k] = cuboids[i][k + 1];
                    cuboids[i][k + 1] = temp;
                }
            }
        }
    }

    for (int i = 0; i < cuboidsSize; i++) {
        for (int j = i + 1; j < cuboidsSize; j++) {
            if (cuboids[i][2] > cuboids[j][2] || 
                (cuboids[i][2] == cuboids[j][2] && cuboids[i][1] > cuboids[j][1]) ||
                (cuboids[i][2] == cuboids[j][2] && cuboids[i][1] == cuboids[j][1] && cuboids[i][0] > cuboids[j][0])) {
                int temp[3];
                temp[0] = cuboids[i][0];
                temp[1] = cuboids[i][1];
                temp[2] = cuboids[i][2];
                cuboids[i][0] = cuboids[j][0];
                cuboids[i][1] = cuboids[j][1];
                cuboids[i][2] = cuboids[j][2];
                cuboids[j][0] = temp[0];
                cuboids[j][1] = temp[1];
                cuboids[j][2] = temp[2];
            }
        }
    }

    int dp[cuboidsSize];
    int maxH = 0;
    for (int i = 0; i < cuboidsSize; i++) {
        dp[i] = cuboids[i][2];
        for (int j = 0; j < i; j++) {
            if (cuboids[j][0] <= cuboids[i][0] && cuboids[j][1] <= cuboids[i][1] && cuboids[j][2] <= cuboids[i][2]) {
                if (dp[j] + cuboids[i][2] > dp[i]) {
                    dp[i] = dp[j] + cuboids[i][2];
                }
            }
        }
        if (dp[i] > maxH) {
            maxH = dp[i];
        }
    }
    return maxH;
}