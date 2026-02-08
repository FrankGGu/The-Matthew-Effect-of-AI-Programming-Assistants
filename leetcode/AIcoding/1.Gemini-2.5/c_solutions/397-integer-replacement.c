int integerReplacement(int n_int) {
    long long n = n_int;
    int count = 0;

    while (n != 1) {
        if (n % 2 == 0) {
            n /= 2;
        } else {
            if (n == 3) {
                n = 2;
            } else if ((n & 3) == 1) { // n % 4 == 1
                n -= 1;
            } else { // n % 4 == 3
                n += 1;
            }
        }
        count++;
    }

    return count;
}