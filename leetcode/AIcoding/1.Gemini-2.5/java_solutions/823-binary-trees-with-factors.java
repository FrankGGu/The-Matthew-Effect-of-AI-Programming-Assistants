import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numFactoredBinaryTrees(int[] arr) {
        long MOD = 1_000_000_007;
        int n = arr.length;
        Arrays.sort(arr);

        long[] dp = new long[n];
        Map<Integer, Integer> valToIndex = new HashMap<>();

        for (int i = 0; i < n; i++) {
            dp[i] = 1; // Each element itself is a tree
            valToIndex.put(arr[i], i);

            for (int j = 0; j < i; j++) {
                if (arr[i] % arr[j] == 0) { // arr[j] is a potential left child
                    int rightChildVal = arr[i] / arr[j];
                    if (valToIndex.containsKey(rightChildVal)) {
                        int rightChildIndex = valToIndex.get(rightChildVal);
                        dp[i] = (dp[i] + (dp[j] * dp[rightChildIndex]) % MOD) % MOD;
                    }
                }
            }
        }

        long totalTrees = 0;
        for (long count : dp) {
            totalTrees = (totalTrees + count) % MOD;
        }

        return (int) totalTrees;
    }
}