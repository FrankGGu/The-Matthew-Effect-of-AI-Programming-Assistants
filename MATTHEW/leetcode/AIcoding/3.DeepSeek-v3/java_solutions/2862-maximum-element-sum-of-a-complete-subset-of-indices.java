class Solution {
    public long maximumSum(List<Integer> nums) {
        int n = nums.size();
        long maxSum = 0;
        boolean[] visited = new boolean[n + 1];

        for (int i = 1; i <= n; i++) {
            if (!visited[i]) {
                long currentSum = 0;
                int j = 1;
                while (i * j * j <= n) {
                    int idx = i * j * j;
                    currentSum += nums.get(idx - 1);
                    visited[idx] = true;
                    j++;
                }
                if (currentSum > maxSum) {
                    maxSum = currentSum;
                }
            }
        }
        return maxSum;
    }
}