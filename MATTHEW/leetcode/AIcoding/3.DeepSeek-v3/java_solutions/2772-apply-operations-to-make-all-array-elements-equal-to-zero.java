class Solution {
    public boolean checkArray(int[] nums, int k) {
        int n = nums.length;
        int[] diff = new int[n + 1];
        int current = 0;

        for (int i = 0; i < n; i++) {
            current += diff[i];
            int adjusted = nums[i] + current;

            if (adjusted == 0) {
                continue;
            } else if (adjusted < 0 || i + k > n) {
                return false;
            }

            current -= adjusted;
            diff[i + k] += adjusted;
        }

        return true;
    }
}