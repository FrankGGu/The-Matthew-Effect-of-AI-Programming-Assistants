class Solution {
    public int threeSumMulti(int[] arr, int target) {
        long count = 0;
        int MOD = 1000000007;
        long[] freq = new long[101];
        for (int num : arr) {
            freq[num]++;
        }

        for (int i = 0; i <= 100; i++) {
            for (int j = i; j <= 100; j++) {
                int k = target - i - j;
                if (k < 0 || k > 100) continue;

                if (i == j && j == k) {
                    count = (count + (freq[i] * (freq[i] - 1) * (freq[i] - 2)) / 6) % MOD;
                } else if (i == j && j != k) {
                    count = (count + (freq[i] * (freq[i] - 1) / 2) * freq[k]) % MOD;
                } else if (i < j && j == k) {
                    count = (count + (freq[i] * (freq[j] * (freq[j] - 1) / 2))) % MOD;
                } else if (i < j && j < k) {
                    count = (count + (freq[i] * freq[j] * freq[k])) % MOD;
                }
            }
        }

        return (int) count;
    }
}