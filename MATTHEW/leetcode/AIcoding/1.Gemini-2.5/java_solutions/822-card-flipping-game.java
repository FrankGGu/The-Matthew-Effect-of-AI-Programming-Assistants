import java.util.HashSet;
import java.util.Set;

class Solution {
    public int flipgame(int[] fronts, int[] backs) {
        Set<Integer> badNumbers = new HashSet<>();
        int n = fronts.length;

        for (int i = 0; i < n; i++) {
            if (fronts[i] == backs[i]) {
                badNumbers.add(fronts[i]);
            }
        }

        int minX = Integer.MAX_VALUE;
        Set<Integer> allCardValues = new HashSet<>();

        for (int i = 0; i < n; i++) {
            allCardValues.add(fronts[i]);
            allCardValues.add(backs[i]);

            if (!badNumbers.contains(fronts[i])) {
                minX = Math.min(minX, fronts[i]);
            }
            if (!badNumbers.contains(backs[i])) {
                minX = Math.min(minX, backs[i]);
            }
        }

        if (minX == Integer.MAX_VALUE) {
            int k = 1;
            while (allCardValues.contains(k)) {
                k++;
            }
            return k;
        } else {
            return minX;
        }
    }
}