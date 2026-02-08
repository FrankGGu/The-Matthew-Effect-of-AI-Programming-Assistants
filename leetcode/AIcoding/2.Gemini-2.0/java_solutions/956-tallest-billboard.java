import java.util.HashMap;
import java.util.Map;

class Solution {
    public int tallestBillboard(int[] rods) {
        Map<Integer, Integer> dp = new HashMap<>();
        dp.put(0, 0);

        for (int rod : rods) {
            Map<Integer, Integer> newDp = new HashMap<>(dp);
            for (Map.Entry<Integer, Integer> entry : dp.entrySet()) {
                int diff = entry.getKey();
                int height = entry.getValue();

                newDp.put(diff + rod, Math.max(newDp.getOrDefault(diff + rod, 0), height));
                newDp.put(Math.abs(diff - rod), Math.max(newDp.getOrDefault(Math.abs(diff - rod), 0), height + Math.min(diff, rod)));
            }
            dp = newDp;
        }

        return dp.getOrDefault(0, 0);
    }
}