int minimumSum(int n, int k) {
    int sum = 0;
    int num = 1;
    int count = 0;

    while (count < n) {
        if (k - num > num) {
            sum += num;
            count++;
        } else {
            sum += k + count;
            count++;
        }
        num++;
    }

    return sum;
}