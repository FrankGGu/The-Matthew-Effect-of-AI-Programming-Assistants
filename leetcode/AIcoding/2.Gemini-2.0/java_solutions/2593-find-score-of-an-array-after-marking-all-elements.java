import java.util.Arrays;

class Solution {
    public long findScore(int[] nums) {
        int n = nums.length;
        long score = 0;
        boolean[] marked = new boolean[n];
        int[][] indexedNums = new int[n][2];
        for (int i = 0; i < n; i++) {
            indexedNums[i][0] = nums[i];
            indexedNums[i][1] = i;
        }

        Arrays.sort(indexedNums, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            } else {
                return a[1] - b[1];
            }
        });

        for (int i = 0; i < n; i++) {
            int index = indexedNums[i][1];
            if (!marked[index]) {
                score += nums[index];
                marked[index] = true;
                if (index > 0) {
                    marked[index - 1] = true;
                }
                if (index < n - 1) {
                    marked[index + 1] = true;
                }
            }
        }

        return score;
    }
}