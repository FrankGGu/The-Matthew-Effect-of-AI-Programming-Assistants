class Solution {
    public int arrayNesting(int[] nums) {
        int n = nums.length;
        boolean[] visited = new boolean[n];
        int maxLen = 0;

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                int current = i;
                int currentLen = 0;
                while (!visited[current]) {
                    visited[current] = true;
                    current = nums[current];
                    currentLen++;
                }
                maxLen = Math.max(maxLen, currentLen);
            }
        }
        return maxLen;
    }
}