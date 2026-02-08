public class Solution {

import java.util.*;

public class Solution {
    public int maximumTotalDamage(List<Integer> power) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int p : power) {
            count.put(p, count.getOrDefault(p, 0) + 1);
        }

        List<Integer> sortedPowers = new ArrayList<>(count.keySet());
        Collections.sort(sortedPowers);

        int n = sortedPowers.size();
        int[] dp = new int[n];

        for (int i = 0; i < n; i++) {
            int currentPower = sortedPowers.get(i);
            int currentDamage = currentPower * count.get(currentPower);
            dp[i] = currentDamage;

            for (int j = 0; j < i; j++) {
                int prevPower = sortedPowers.get(j);
                if (currentPower - prevPower > 1) {
                    dp[i] = Math.max(dp[i], dp[j] + currentDamage);
                }
            }
        }

        int maxDamage = 0;
        for (int damage : dp) {
            maxDamage = Math.max(maxDamage, damage);
        }

        return maxDamage;
    }
}
}