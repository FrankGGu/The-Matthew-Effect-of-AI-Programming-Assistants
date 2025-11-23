int clearDigits(int num) {
    int result = 0;
    while (num > 0) {
        int digit = num % 10;
        if (digit != 0 && digit != 1) {
            result = result * 10 + digit;
        }
        num /= 10;
    }
    int finalResult = 0;
    while (result > 0) {
        finalResult = finalResult * 10 + (result % 10);
        result /= 10;
    }
    return finalResult;
}