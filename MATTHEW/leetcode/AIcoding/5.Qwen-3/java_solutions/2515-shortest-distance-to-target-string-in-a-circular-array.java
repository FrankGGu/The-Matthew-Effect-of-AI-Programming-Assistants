public class Solution {
    public int closetTarget(int[] nums, String target, int startIndex) {
        int n = nums.length;
        int minDistance = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            if (nums[i].equals(target)) {
                int distance = Math.min(Math.abs(i - startIndex), n - Math.abs(i - startIndex));
                minDistance = Math.min(minDistance, distance);
            }
        }
        return minDistance;
    }
}