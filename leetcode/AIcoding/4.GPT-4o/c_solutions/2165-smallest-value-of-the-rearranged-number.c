int smallestNumber(int num) {
    if (num == 0) return 0;
    int isNegative = num < 0;
    num = abs(num);
    int count[10] = {0};
    while (num) {
        count[num % 10]++;
        num /= 10;
    }
    if (isNegative) {
        long long result = 0;
        for (int i = 9; i >= 0; i--) {
            while (count[i]--) {
                result = result * 10 + i;
            }
        }
        return -result;
    } else {
        long long result = 0;
        for (int i = 1; i < 10; i++) {
            if (count[i]) {
                result = i;
                count[i]--;
                break;
            }
        }
        for (int i = 0; i < 10; i++) {
            while (count[i]--) {
                result = result * 10 + i;
            }
        }
        return result;
    }
}