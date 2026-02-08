class Solution {
    public int minimumScore(int[] nums, int[][] edges) {
        int n = nums.length;
        int minScore = Integer.MAX_VALUE;

        for (int[] edge : edges) {
            int u = edge[0] - 1;
            int v = edge[1] - 1;
            minScore = Math.min(minScore, Math.min(nums[u], nums[v]));
        }

        return minScore;
    }
}