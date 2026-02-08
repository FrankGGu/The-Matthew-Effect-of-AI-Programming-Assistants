int countBalls(int lowLimit, int highLimit) {
    int count[46] = {0};
    int maxBalls = 0;

    for (int i = lowLimit; i <= highLimit; i++) {
        int sum = 0, n = i;
        while (n > 0) {
            sum += n % 10;
            n /= 10;
        }
        count[sum]++;
        if (count[sum] > maxBalls) {
            maxBalls = count[sum];
        }
    }

    return maxBalls;
}