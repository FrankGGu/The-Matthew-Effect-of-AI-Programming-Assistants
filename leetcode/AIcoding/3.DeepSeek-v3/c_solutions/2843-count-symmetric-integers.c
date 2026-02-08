int countSymmetricIntegers(int low, int high) {
    int count = 0;
    for (int num = low; num <= high; num++) {
        char str[10];
        sprintf(str, "%d", num);
        int len = strlen(str);

        if (len % 2 != 0) continue;

        int half = len / 2;
        int sum1 = 0, sum2 = 0;

        for (int i = 0; i < half; i++) {
            sum1 += str[i] - '0';
        }
        for (int i = half; i < len; i++) {
            sum2 += str[i] - '0';
        }

        if (sum1 == sum2) {
            count++;
        }
    }
    return count;
}