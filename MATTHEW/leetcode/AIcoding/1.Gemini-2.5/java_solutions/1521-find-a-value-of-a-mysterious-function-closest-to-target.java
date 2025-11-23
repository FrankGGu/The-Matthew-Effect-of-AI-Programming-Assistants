import java.util.HashSet;
import java.util.Set;

class Solution {
    public int closestToTarget(int[] arr, int target) {
        int minDiff = Integer.MAX_VALUE;
        Set<Integer> currentAndValues = new HashSet<>();

        for (int num : arr) {
            Set<Integer> nextAndValues = new HashSet<>();

            nextAndValues.add(num);

            for (int prevAnd : currentAndValues) {
                nextAndValues.add(prevAnd & num);
            }

            for (int val : nextAndValues) {
                minDiff = Math.min(minDiff, Math.abs(val - target));
                if (minDiff == 0) {
                    return 0;
                }
            }

            currentAndValues = nextAndValues;
        }

        return minDiff;
    }
}