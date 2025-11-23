import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public String[] findRelativeRanks(int[] score) {
        int n = score.length;
        int[] sortedScore = Arrays.copyOf(score, n);
        Arrays.sort(sortedScore);

        Map<Integer, Integer> rankMap = new HashMap<>();
        for (int i = 0; i < n; i++) {
            rankMap.put(sortedScore[i], n - 1 - i);
        }

        String[] result = new String[n];
        for (int i = 0; i < n; i++) {
            int rank = rankMap.get(score[i]);
            if (rank == 0) {
                result[i] = "Gold Medal";
            } else if (rank == 1) {
                result[i] = "Silver Medal";
            } else if (rank == 2) {
                result[i] = "Bronze Medal";
            } else {
                result[i] = String.valueOf(rank + 1);
            }
        }

        return result;
    }
}