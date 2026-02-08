import java.util.*;

class Solution {
    public int[] avoidFlood(int[] rains) {
        int n = rains.length;
        int[] ans = new int[n];
        Arrays.fill(ans, 1);
        TreeSet<Integer> dryDays = new TreeSet<>();
        HashMap<Integer, Integer> flooded = new HashMap<>();

        for (int i = 0; i < n; i++) {
            if (rains[i] > 0) {
                int lake = rains[i];
                if (flooded.containsKey(lake)) {
                    return new int[0];
                }
                flooded.put(lake, i);
                ans[i] = -1;
            } else {
                dryDays.add(i);
            }

            if (ans[i] == -1) {
                continue;
            }

            if (!flooded.isEmpty() && !dryDays.isEmpty()) {
                for (Map.Entry<Integer, Integer> entry : flooded.entrySet()) {
                    int lake = entry.getKey();
                    int lastRainDay = entry.getValue();
                    Integer nextDryDay = dryDays.higher(lastRainDay);
                    if (nextDryDay != null) {
                        ans[nextDryDay] = lake;
                        flooded.remove(lake);
                        dryDays.remove(nextDryDay);
                        break;
                    }
                }
            }
        }

        return ans;
    }
}