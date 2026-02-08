class Solution {
    public int closestToTarget(int[][] grid, int target) {
        int closest = Integer.MAX_VALUE;
        for (int[] row : grid) {
            for (int num : row) {
                closest = Math.min(closest, Math.abs(num - target));
            }
        }
        return closest;
    }
}