class Solution {
    public int sumOfFlooredPairs(int[] nums) {
        int MOD = 1_000_000_007;
        int maxNum = 0;
        for (int num : nums) {
            maxNum = Math.max(maxNum, num);
        }

        int[] count = new int[maxNum + 1];
        for (int num : nums) {
            count[num]++;
        }

        int[] prefix = new int[maxNum + 1];
        prefix[0] = count[0];
        for (int i = 1; i <= maxNum; i++) {
            prefix[i] = prefix[i - 1] + count[i];
        }

        long res = 0;
        for (int i = 1; i <= maxNum; i++) {
            if (count[i] == 0) continue;
            for (int j = 1; i * j <= maxNum; j++) {
                int lower = i * j;
                int upper = i * (j + 1) - 1;
                upper = Math.min(upper, maxNum);
                if (lower > maxNum) break;
                int cnt = prefix[upper] - prefix[lower - 1];
                res = (res + (long) j * count[i] * cnt) % MOD;
            }
        }
        return (int) res;
    }
}