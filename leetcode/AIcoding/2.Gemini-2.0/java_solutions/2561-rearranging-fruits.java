import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minCost(int[] basket1, int[] basket2) {
        Map<Integer, Integer> count = new HashMap<>();
        int minVal = Integer.MAX_VALUE;
        for (int num : basket1) {
            count.put(num, count.getOrDefault(num, 0) + 1);
            minVal = Math.min(minVal, num);
        }
        for (int num : basket2) {
            count.put(num, count.getOrDefault(num, 0) - 1);
            minVal = Math.min(minVal, num);
        }

        List<Integer> diff = new ArrayList<>();
        for (int num : count.keySet()) {
            if (count.get(num) != 0) {
                for (int i = 0; i < Math.abs(count.get(num) / 2); i++) {
                    diff.add(num);
                }
            }
        }

        Collections.sort(diff);
        long cost = 0;
        for (int num : diff) {
            cost += Math.min(num, 2 * minVal);
        }

        return (int) cost;
    }
}