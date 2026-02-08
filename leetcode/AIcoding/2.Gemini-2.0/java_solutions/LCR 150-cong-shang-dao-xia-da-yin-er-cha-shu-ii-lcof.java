import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public int minimumTotalCost(int[] cost1, int[] cost2) {
        int n = cost1.length;
        int totalCost = 0;
        Map<Integer, Integer> counts = new HashMap<>();
        int major = -1;
        int majorCount = 0;
        int extra = 0;

        for (int i = 0; i < n; i++) {
            if (cost1[i] == cost2[i]) {
                totalCost += cost1[i];
                counts.put(cost1[i], counts.getOrDefault(cost1[i], 0) + 1);
                if (counts.get(cost1[i]) > majorCount) {
                    majorCount = counts.get(cost1[i]);
                    major = cost1[i];
                }
            }
        }

        if (majorCount <= n / 2) {
            return totalCost;
        }

        List<Integer> remaining = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (cost1[i] == cost2[i]) {
                continue;
            }
            remaining.add(i);
        }

        for (int i : remaining) {
            if (cost1[i] != major && cost2[i] != major) {
                totalCost += Math.min(cost1[i], cost2[i]);
                majorCount++;
                if (majorCount > n / 2) {
                    break;
                }
            }
        }

        if (majorCount > n / 2) {
            return totalCost;
        } else {
            return -1;
        }
    }
}