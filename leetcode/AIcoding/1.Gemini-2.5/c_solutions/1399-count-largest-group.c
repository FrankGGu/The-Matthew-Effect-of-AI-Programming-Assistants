int countLargestGroup(int n) {
    int freq[37] = {0}; // Max digit sum for n=10000 is 9+9+9+9 = 36

    for (int i = 1; i <= n; i++) {
        int num = i;
        int currentSum = 0;
        while (num > 0) {
            currentSum += num % 10;
            num /= 10;
        }
        freq[currentSum]++;
    }

    int maxFreq = 0;
    for (int i = 1; i <= 36; i++) { // Iterate through possible digit sums
        if (freq[i] > maxFreq) {
            maxFreq = freq[i];
        }
    }

    int countLargest = 0;
    for (int i = 1; i <= 36; i++) {
        if (freq[i] == maxFreq) {
            countLargest++;
        }
    }

    return countLargest;
}