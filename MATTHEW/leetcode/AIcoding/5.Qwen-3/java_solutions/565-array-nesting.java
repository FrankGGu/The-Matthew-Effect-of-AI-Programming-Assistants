public class Solution {
    public int arrayNesting(int[] nums) {
        int max = 0;
        boolean[] visited = new boolean[nums.length];
        for (int i = 0; i < nums.length; i++) {
            if (!visited[i]) {
                int count = 0;
                int j = i;
                while (!visited[j]) {
                    visited[j] = true;
                    j = nums[j];
                    count++;
                }
                max = Math.max(max, count);
            }
        }
        return max;
    }
}