public class Solution {

import java.util.*;

public class Solution {
    public int numBalancedPermutations(int n, int[] counts) {
        int MOD = 1000000007;
        int total = Arrays.stream(counts).sum();
        if (total != n) return 0;

        int[] freq = new int[26];
        for (int i = 0; i < counts.length; i++) {
            freq[i] = counts[i];
        }

        Map<String, Integer> memo = new HashMap<>();
        return dfs(0, 0, 0, n, freq, memo, MOD);
    }

    private int dfs(int pos, int even, int odd, int n, int[] freq, Map<String, Integer> memo, int MOD) {
        if (pos == 26) {
            return even == odd ? 1 : 0;
        }

        String key = pos + "," + even + "," + odd;
        if (memo.containsKey(key)) {
            return memo.get(key);
        }

        int res = 0;
        int count = freq[pos];

        for (int k = 0; k <= count; k++) {
            int rem = count - k;
            int evenNew = even + k;
            int oddNew = odd + rem;

            if (evenNew > n / 2 || oddNew > n / 2) continue;

            int ways = combination(count, k, MOD);
            int next = dfs(pos + 1, evenNew, oddNew, n, freq, memo, MOD);
            res = (res + (long) ways * next) % MOD;
        }

        memo.put(key, res);
        return res;
    }

    private int combination(int n, int k, int MOD) {
        long res = 1;
        for (int i = 0; i < k; i++) {
            res = res * (n - i) / (i + 1);
        }
        return (int) res;
    }
}
}