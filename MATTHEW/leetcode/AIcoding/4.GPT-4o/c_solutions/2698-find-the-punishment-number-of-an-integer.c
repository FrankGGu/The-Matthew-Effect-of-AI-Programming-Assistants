int punishmentNumber(int n) {
    int punishmentSum = 0;

    for (int i = 1; i <= n; i++) {
        int square = i * i;
        int temp = square, sum = 0;

        while (temp > 0) {
            sum += temp % 10;
            temp /= 10;
        }

        if (sum == i) {
            punishmentSum += square;
        }
    }

    return punishmentSum;
}