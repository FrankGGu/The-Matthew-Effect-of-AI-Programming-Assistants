int nextBeautifulNumber(int n) {
    if (n == 0) return 1;

    int count[10] = {0};

    for (int num = n + 1; num <= 2000000; num++) {
        int temp = num;
        for (int i = 0; i < 10; i++) count[i] = 0;

        while (temp > 0) {
            int digit = temp % 10;
            if (digit == 0) break;
            count[digit]++;
            temp /= 10;
        }

        if (temp > 0) continue;

        int valid = 1;
        for (int i = 1; i < 10; i++) {
            if (count[i] > 0 && count[i] != i) {
                valid = 0;
                break;
            }
        }

        if (valid) return num;
    }

    return -1;
}