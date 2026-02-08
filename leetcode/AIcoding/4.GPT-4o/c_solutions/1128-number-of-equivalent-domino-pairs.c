int numEquivDominoPairs(int** dominoes, int dominoesSize, int* dominoesColSize) {
    int count[100] = {0};
    int result = 0;

    for (int i = 0; i < dominoesSize; i++) {
        int a = dominoes[i][0];
        int b = dominoes[i][1];
        if (a > b) {
            int temp = a;
            a = b;
            b = temp;
        }
        count[a * 10 + b]++;
    }

    for (int i = 0; i < 100; i++) {
        result += (count[i] * (count[i] - 1)) / 2;
    }

    return result;
}