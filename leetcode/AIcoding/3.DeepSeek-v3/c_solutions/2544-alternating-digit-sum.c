int alternateDigitSum(int n) {
    int sum = 0;
    int sign = 1;
    int digits = 0;
    int temp = n;

    while (temp > 0) {
        digits++;
        temp /= 10;
    }

    if (digits % 2 == 0) {
        sign = -1;
    }

    while (n > 0) {
        sum += sign * (n % 10);
        n /= 10;
        sign *= -1;
    }

    return sum;
}