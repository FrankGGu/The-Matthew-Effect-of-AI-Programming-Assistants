int maximum69Number (int num) {
    int temp = num;
    int divisor = 1;

    while (temp > 9) {
        temp /= 10;
        divisor *= 10;
    }

    temp = num;
    while (divisor > 0) {
        if (temp / divisor == 6) {
            num += 3 * divisor;
            break;
        }
        temp %= divisor;
        divisor /= 10;
    }

    return num;
}