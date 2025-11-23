class Solution {
    public boolean canReach(int[] nums, int start) {
        int n = nums.length;
        boolean[] visited = new boolean[n];
        return canReachHelper(nums, start, visited);
    }

    private boolean canReachHelper(int[] nums, int start, boolean[] visited) {
        if (start < 0 || start >= nums.length || visited[start]) {
            return false;
        }
        if (nums[start] == 0) {
            return true;
        }
        visited[start] = true;
        return canReachHelper(nums, start + nums[start], visited) || canReachHelper(nums, start - nums[start], visited);
    }
}