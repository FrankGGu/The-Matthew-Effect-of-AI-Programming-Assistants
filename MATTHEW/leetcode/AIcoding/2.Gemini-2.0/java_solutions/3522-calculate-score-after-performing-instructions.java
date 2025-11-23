class Solution {
    public long[] calculateScore(int[] nums, int[][] operations) {
        int n = nums.length;
        boolean[] visited = new boolean[n];
        long[] res = new long[operations.length];
        long score = 0;

        for (int i = 0; i < n; i++) {
            score += nums[i];
        }

        for (int i = 0; i < operations.length; i++) {
            int index = operations[i][0];
            int val = operations[i][1];

            if (!visited[index]) {
                score -= nums[index];
                nums[index] = val;
                visited[index] = true;
                res[i] = score;
            } else {
                res[i] = score;
            }
        }

        return res;
    }
}