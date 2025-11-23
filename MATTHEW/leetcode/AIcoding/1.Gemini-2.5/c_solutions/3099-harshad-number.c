int sumDigits(int num) {
    int sum = 0;
    int temp = num;
    while (temp > 0) {
        sum += temp % 10;
        temp /= 10;
    }
    return sum;
}

bool isHarshad(int x) {
    int s = sumDigits(x);
    return x % s == 0;
}