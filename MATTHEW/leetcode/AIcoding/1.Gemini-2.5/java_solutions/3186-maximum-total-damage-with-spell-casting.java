import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public long maximumTotalDamage(int[] damages) {
        Map<Integer, Long> damageTotals = new HashMap<>();
        for (int damage : damages) {
            damageTotals.put(damage, damageTotals.getOrDefault(damage, 0L) + damage);
        }

        List<Integer> distinctDamages = new ArrayList<>(damageTotals.keySet());
        Collections.sort(distinctDamages);

        int n = distinctDamages.size();
        if (n == 0) {
            return 0;
        }

        long[] dp = new long[n];

        dp[0] = damageTotals.get(distinctDamages.get(0));

        for (int i = 1; i < n; i++) {
            int currentDamage = distinctDamages.get(i);
            long currentDamageValue = damageTotals.get(currentDamage);

            long option1 = dp[i - 1];

            long option2 = currentDamageValue;

            int prevNonConflictingIndex = -1;
            int low = 0, high = i - 1;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                if (distinctDamages.get(mid) <= currentDamage - 2) {
                    prevNonConflictingIndex = mid;
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }

            if (prevNonConflictingIndex != -1) {
                option2 += dp[prevNonConflictingIndex];
            }

            dp[i] = Math.max(option1, option2);
        }

        return dp[n - 1];
    }
}