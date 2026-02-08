import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maximumTotalDamage(int[] power) {
        Arrays.sort(power);
        Map<Integer, Integer> freq = new HashMap<>();
        for (int p : power) {
            freq.put(p, freq.getOrDefault(p, 0) + 1);
        }

        int[] unique = new int[freq.size()];
        int index = 0;
        for (int key : freq.keySet()) {
            unique[index++] = key;
        }
        Arrays.sort(unique);

        int n = unique.length;
        int[] dp = new int[n + 1];
        dp[0] = 0;

        for (int i = 0; i < n; i++) {
            int current = unique[i];
            int total = current * freq.get(current);

            int j = i - 1;
            while (j >= 0 && unique[j] >= current - 2) {
                j--;
            }

            if (j >= 0) {
                dp[i + 1] = Math.max(dp[i], dp[j + 1] + total);
            } else {
                dp[i + 1] = Math.max(dp[i], total);
            }
        }

        return dp[n];
    }
}