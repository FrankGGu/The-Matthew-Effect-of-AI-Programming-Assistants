int makeIntegerBeautiful(int n, int target) {
    long long sum = 0, add = 0;
    long long temp = n;

    while (temp > 0) {
        sum += temp % 10;
        temp /= 10;
    }

    while (sum > target) {
        add += 10 - (n % 10);
        n += 10 - (n % 10);
        sum = 0;
        temp = n;

        while (temp > 0) {
            sum += temp % 10;
            temp /= 10;
        }
    }

    return add;
}