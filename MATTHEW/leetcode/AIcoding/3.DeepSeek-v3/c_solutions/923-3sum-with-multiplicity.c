int threeSumMulti(int* arr, int arrSize, int target) {
    long mod = 1000000007;
    long count = 0;
    long freq[101] = {0};

    for (int i = 0; i < arrSize; i++) {
        freq[arr[i]]++;
    }

    for (int i = 0; i <= 100; i++) {
        for (int j = i; j <= 100; j++) {
            int k = target - i - j;
            if (k < j || k > 100) continue;

            if (i == j && j == k) {
                count += freq[i] * (freq[i] - 1) * (freq[i] - 2) / 6;
            } else if (i == j && j != k) {
                count += freq[i] * (freq[i] - 1) / 2 * freq[k];
            } else if (i != j && j == k) {
                count += freq[i] * freq[j] * (freq[j] - 1) / 2;
            } else {
                count += freq[i] * freq[j] * freq[k];
            }
            count %= mod;
        }
    }

    return (int)count;
}