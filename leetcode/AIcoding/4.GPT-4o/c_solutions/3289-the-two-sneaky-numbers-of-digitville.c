int[] findSneakyNumbers(int n) {
    int result[2];
    int count = 0;
    for (int i = 1; count < 2; i++) {
        int num = i;
        int digitSum = 0;
        while (num > 0) {
            digitSum += num % 10;
            num /= 10;
        }
        if (digitSum % 2 == 0) {
            result[count++] = i;
        }
    }
    return result;
}