import java.util.*;

class Solution {
    public long minCost(int[] basket1, int[] basket2) {
        TreeMap<Integer, Integer> counts = new TreeMap<>();
        int minVal = Integer.MAX_VALUE;

        for (int fruit : basket1) {
            counts.put(fruit, counts.getOrDefault(fruit, 0) + 1);
            minVal = Math.min(minVal, fruit);
        }
        for (int fruit : basket2) {
            counts.put(fruit, counts.getOrDefault(fruit, 0) - 1);
            minVal = Math.min(minVal, fruit);
        }

        List<Integer> excessIn1 = new ArrayList<>();
        List<Integer> excessIn2 = new ArrayList<>();

        for (Map.Entry<Integer, Integer> entry : counts.entrySet()) {
            int fruit = entry.getKey();
            int diff = entry.getValue();

            if (diff % 2 != 0) {
                return -1;
            }

            if (diff > 0) {
                for (int i = 0; i < diff / 2; i++) {
                    excessIn1.add(fruit);
                }
            } else if (diff < 0) {
                for (int i = 0; i < -diff / 2; i++) {
                    excessIn2.add(fruit);
                }
            }
        }

        Collections.sort(excessIn1);
        Collections.sort(excess2);

        long totalCost = 0;
        int k = excessIn1.size();
        for (int i = 0; i < k; i++) {
            totalCost += Math.min(Math.min(excessIn1.get(i), excessIn2.get(i)), 2 * minVal);
        }

        return totalCost;
    }
}