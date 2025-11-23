int maximum69Number (int num) {
    int factor = 1, maxNum = num;
    while (num > 0) {
        if (num % 10 == 6) {
            maxNum = maxNum - 6 * factor + 9 * factor;
            break;
        }
        num /= 10;
        factor *= 10;
    }
    return maxNum;
}