import java.util.HashMap;

public class Solution {
    public int tallestBillboard(int[] rods) {
        HashMap<Integer, Integer> dp = new HashMap<>();
        dp.put(0, 0);

        for (int rod : rods) {
            HashMap<Integer, Integer> currentDp = new HashMap<>(dp);
            for (int diff : dp.keySet()) {
                int height = dp.get(diff);

                // Case 1: Add rod to the taller side
                currentDp.put(diff + rod, Math.max(currentDp.getOrDefault(diff + rod, 0), height));

                // Case 2: Add rod to the shorter side
                currentDp.put(diff - rod, Math.max(currentDp.getOrDefault(diff - rod, 0), height + (diff >= rod ? rod : 0)));

                // Case 3: Do not use the rod
                currentDp.put(diff, Math.max(currentDp.getOrDefault(diff, 0), height));
            }
            dp = currentDp;
        }

        return dp.getOrDefault(0, 0);
    }
}