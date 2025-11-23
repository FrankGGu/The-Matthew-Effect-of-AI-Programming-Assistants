int countLargestGroup(int n){
    int count[37] = {0};
    int maxCount = 0;

    for (int i = 1; i <= n; i++) {
        int sum = 0, num = i;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        count[sum]++;
        if (count[sum] > maxCount) {
            maxCount = count[sum];
        }
    }

    int largestGroupCount = 0;
    for (int i = 0; i < 37; i++) {
        if (count[i] == maxCount) {
            largestGroupCount++;
        }
    }

    return largestGroupCount;
}