#define MOD 1000000007

int countPairs(int* deliciousness, int deliciousnessSize) {
    long long count = 0;
    int freq[1 << 22] = {0};

    for (int i = 0; i < deliciousnessSize; i++) {
        freq[deliciousness[i]]++;
    }

    for (int i = 0; i <= 21; i++) {
        long long target = 1 << i;
        for (int j = 0; j <= target / 2; j++) {
            if (j == target - j) {
                count = (count + (long long)freq[j] * (freq[j] - 1) / 2) % MOD;
            } else {
                count = (count + (long long)freq[j] * freq[target - j]) % MOD;
            }
        }
    }

    return (int)count;
}