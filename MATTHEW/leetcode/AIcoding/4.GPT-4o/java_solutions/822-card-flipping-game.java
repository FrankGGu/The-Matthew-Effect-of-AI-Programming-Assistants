import java.util.HashSet;

public class Solution {
    public int flipgame(int[] fronts, int[] backs) {
        HashSet<Integer> badNumbers = new HashSet<>();
        for (int i = 0; i < fronts.length; i++) {
            if (fronts[i] == backs[i]) {
                badNumbers.add(fronts[i]);
            }
        }
        int min = Integer.MAX_VALUE;
        for (int front : fronts) {
            if (!badNumbers.contains(front)) {
                min = Math.min(min, front);
            }
        }
        for (int back : backs) {
            if (!badNumbers.contains(back)) {
                min = Math.min(min, back);
            }
        }
        return min == Integer.MAX_VALUE ? 0 : min;
    }
}