int alternatingDigitSum(int n) {
    int temp_n = n;
    int k = 0;

    while (temp_n > 0) {
        temp_n /= 10;
        k++;
    }

    int sum = 0;
    int sign;

    if (k % 2 == 0) {
        sign = -1;
    } else {
        sign = 1;
    }

    temp_n = n;
    while (temp_n > 0) {
        int digit = temp_n % 10;
        sum += sign * digit;
        sign *= -1;
        temp_n /= 10;
    }

    return sum;
}