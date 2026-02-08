int countGoodIntegers(int low, int high) {
    int count = 0;
    for (int num = low; num <= high; num++) {
        int prevDigit = -1;
        int isGood = 1;
        int temp = num;

        while (temp > 0) {
            int currentDigit = temp % 10;
            if (currentDigit == prevDigit) {
                isGood = 0;
                break;
            }
            prevDigit = currentDigit;
            temp /= 10;
        }

        if (isGood) {
            count++;
        }
    }
    return count;
}