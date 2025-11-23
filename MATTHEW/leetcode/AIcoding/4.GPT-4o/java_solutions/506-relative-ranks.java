import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public String[] findRelativeRanks(int[] score) {
        int n = score.length;
        String[] result = new String[n];
        int[] sortedScores = score.clone();
        Arrays.sort(sortedScores);

        Map<Integer, String> rankMap = new HashMap<>();
        for (int i = n - 1; i >= 0; i--) {
            if (i == n - 1) {
                rankMap.put(sortedScores[i], "Gold Medal");
            } else if (i == n - 2) {
                rankMap.put(sortedScores[i], "Silver Medal");
            } else if (i == n - 3) {
                rankMap.put(sortedScores[i], "Bronze Medal");
            } else {
                rankMap.put(sortedScores[i], String.valueOf(n - i));
            }
        }

        for (int i = 0; i < n; i++) {
            result[i] = rankMap.get(score[i]);
        }

        return result;
    }
}