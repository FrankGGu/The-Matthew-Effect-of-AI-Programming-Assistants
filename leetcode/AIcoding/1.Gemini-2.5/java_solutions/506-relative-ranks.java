import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public String[] findRelativeRanks(int[] score) {
        int n = score.length;
        int[][] indexedScores = new int[n][2]; // [score, original_index]

        for (int i = 0; i < n; i++) {
            indexedScores[i][0] = score[i];
            indexedScores[i][1] = i;
        }

        // Sort in descending order based on score
        Arrays.sort(indexedScores, new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                return b[0] - a[0]; // Descending order
            }
        });

        String[] result = new String[n];

        for (int i = 0; i < n; i++) {
            int originalIndex = indexedScores[i][1];
            int rank = i + 1;

            if (rank == 1) {
                result[originalIndex] = "Gold Medal";
            } else if (rank == 2) {
                result[originalIndex] = "Silver Medal";
            } else if (rank == 3) {
                result[originalIndex] = "Bronze Medal";
            } else {
                result[originalIndex] = String.valueOf(rank);
            }
        }

        return result;
    }
}