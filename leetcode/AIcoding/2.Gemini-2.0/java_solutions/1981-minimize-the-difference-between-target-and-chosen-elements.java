import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public int minimizeTheDifference(int[][] mat, int target) {
        int m = mat.length;
        Set<Integer> possibleSums = new HashSet<>();
        possibleSums.add(0);

        for (int i = 0; i < m; i++) {
            Set<Integer> newPossibleSums = new HashSet<>();
            for (int num : mat[i]) {
                for (int sum : possibleSums) {
                    newPossibleSums.add(sum + num);
                }
            }
            possibleSums = newPossibleSums;
        }

        int minDiff = Integer.MAX_VALUE;
        for (int sum : possibleSums) {
            minDiff = Math.min(minDiff, Math.abs(sum - target));
        }

        return minDiff;
    }
}