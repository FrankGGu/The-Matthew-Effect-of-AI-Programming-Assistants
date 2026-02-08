int countLargestGroup(int n) {
    int sum[37] = {0};
    int max = 0, count = 0;

    for (int i = 1; i <= n; i++) {
        int num = i;
        int digitSum = 0;
        while (num > 0) {
            digitSum += num % 10;
            num /= 10;
        }
        sum[digitSum]++;
        if (sum[digitSum] > max) {
            max = sum[digitSum];
        }
    }

    for (int i = 1; i < 37; i++) {
        if (sum[i] == max) {
            count++;
        }
    }

    return count;
}