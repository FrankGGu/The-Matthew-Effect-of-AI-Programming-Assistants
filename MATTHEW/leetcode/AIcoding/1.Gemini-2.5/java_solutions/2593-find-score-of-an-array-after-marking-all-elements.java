import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public long findScore(int[] nums) {
        int n = nums.length;
        int[][] indexedNums = new int[n][2];
        for (int i = 0; i < n; i++) {
            indexedNums[i][0] = nums[i];
            indexedNums[i][1] = i;
        }

        Arrays.sort(indexedNums, new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                if (a[0] != b[0]) {
                    return Integer.compare(a[0], b[0]);
                }
                return Integer.compare(a[1], b[1]);
            }
        });

        long totalScore = 0;
        boolean[] marked = new boolean[n];

        for (int[] pair : indexedNums) {
            int value = pair[0];
            int index = pair[1];

            if (!marked[index]) {
                totalScore += value;
                marked[index] = true;
                if (index - 1 >= 0) {
                    marked[index - 1] = true;
                }
                if (index + 1 < n) {
                    marked[index + 1] = true;
                }
            }
        }

        return totalScore;
    }
}