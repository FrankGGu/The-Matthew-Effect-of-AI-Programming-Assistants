int rotatedDigits(int n) {
    int count = 0;
    for (int i = 1; i <= n; i++) {
        int num = i;
        int valid = 1;
        int changed = 0;
        while (num > 0) {
            int digit = num % 10;
            if (digit == 3 || digit == 4 || digit == 7) {
                valid = 0;
                break;
            }
            if (digit == 2 || digit == 5 || digit == 6 || digit == 9) {
                changed = 1;
            }
            num /= 10;
        }
        if (valid && changed) {
            count++;
        }
    }
    return count;
}