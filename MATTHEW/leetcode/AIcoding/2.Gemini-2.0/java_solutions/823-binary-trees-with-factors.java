import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numFactoredBinaryTrees(int[] arr) {
        Arrays.sort(arr);
        int n = arr.length;
        Map<Integer, Long> dp = new HashMap<>();
        long ans = 0;
        int MOD = 1000000007;

        for (int i = 0; i < n; i++) {
            dp.put(arr[i], 1L);
            for (int j = 0; j < i; j++) {
                if (arr[i] % arr[j] == 0) {
                    int factor2 = arr[i] / arr[j];
                    if (dp.containsKey(factor2)) {
                        dp.put(arr[i], (dp.get(arr[i]) + dp.get(arr[j]) * dp.get(factor2)) % MOD);
                    }
                }
            }
            ans = (ans + dp.get(arr[i])) % MOD;
        }

        return (int) ans;
    }
}