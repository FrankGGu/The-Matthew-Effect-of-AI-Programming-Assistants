int minOperations(int n, int m) {
    if (n == m) return 0;

    int operations = 0;
    while (n != m) {
        if (n < m) {
            int temp = n;
            n = m;
            m = temp;
        }

        if (n % 2 == 0 && n / 2 >= m) {
            n /= 2;
            operations++;
        } else {
            n--;
            operations++;
        }
    }
    return operations;
}