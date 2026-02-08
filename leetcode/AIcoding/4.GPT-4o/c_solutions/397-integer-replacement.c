int integerReplacement(int n) {
    int count = 0;
    while (n > 1) {
        if (n % 2 == 0) {
            n /= 2;
        } else {
            if (n == 3 || (n >> 1) % 2 == 0) {
                n -= 1;
            } else {
                n += 1;
            }
        }
        count++;
    }
    return count;
}