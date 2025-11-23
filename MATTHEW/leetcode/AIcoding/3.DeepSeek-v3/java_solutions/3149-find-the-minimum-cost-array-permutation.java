class Solution {
    private int minCost = Integer.MAX_VALUE;
    private int[] bestPermutation;

    public int[] findPermutation(int[] nums) {
        int n = nums.length;
        boolean[] visited = new boolean[n];
        int[] current = new int[n];
        bestPermutation = new int[n];
        backtrack(nums, visited, current, 0);
        return bestPermutation;
    }

    private void backtrack(int[] nums, boolean[] visited, int[] current, int pos) {
        if (pos == current.length) {
            int cost = 0;
            for (int i = 0; i < current.length; i++) {
                cost += Math.abs(current[i] - nums[current[(i + 1) % current.length]]);
            }
            if (cost < minCost) {
                minCost = cost;
                System.arraycopy(current, 0, bestPermutation, 0, current.length);
            }
            return;
        }

        for (int i = 0; i < nums.length; i++) {
            if (!visited[i]) {
                visited[i] = true;
                current[pos] = i;
                backtrack(nums, visited, current, pos + 1);
                visited[i] = false;
            }
        }
    }
}