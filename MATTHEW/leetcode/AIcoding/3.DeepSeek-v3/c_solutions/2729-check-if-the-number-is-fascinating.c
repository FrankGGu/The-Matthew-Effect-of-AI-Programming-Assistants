bool isFascinating(int n) {
    int n2 = n * 2;
    int n3 = n * 3;

    int digits[10] = {0};

    while (n > 0) {
        digits[n % 10]++;
        n /= 10;
    }

    while (n2 > 0) {
        digits[n2 % 10]++;
        n2 /= 10;
    }

    while (n3 > 0) {
        digits[n3 % 10]++;
        n3 /= 10;
    }

    if (digits[0] > 0) return false;

    for (int i = 1; i <= 9; i++) {
        if (digits[i] != 1) return false;
    }

    return true;
}