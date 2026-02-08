int countBalls(int lowLimit, int highLimit) {
    int box[46] = {0};
    int max = 0;

    for (int i = lowLimit; i <= highLimit; i++) {
        int sum = 0;
        int num = i;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        box[sum]++;
        if (box[sum] > max) {
            max = box[sum];
        }
    }

    return max;
}