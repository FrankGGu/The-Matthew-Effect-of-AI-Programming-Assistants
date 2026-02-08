int countPairs(int* deliciousness, int deliciousnessSize) {
    int mod = 1000000007;
    int maxVal = 0;
    for (int i = 0; i < deliciousnessSize; i++) {
        if (deliciousness[i] > maxVal) {
            maxVal = deliciousness[i];
        }
    }
    int maxSum = maxVal * 2;
    int count = 0;
    int freq[1 << 22] = {0};

    for (int i = 0; i < deliciousnessSize; i++) {
        int val = deliciousness[i];
        for (int sum = 1; sum <= maxSum; sum <<= 1) {
            int target = sum - val;
            if (target < 0) continue;
            if (target <= maxVal) {
                count = (count + freq[target]) % mod;
            }
        }
        freq[val]++;
    }
    return count;
}