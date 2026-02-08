class Solution {
    public boolean canBeSorted(int[] nums) {
        int n = nums.length;
        int[] sorted = nums.clone();
        Arrays.sort(sorted);

        for (int i = 0; i < n; i++) {
            if (nums[i] != sorted[i]) {
                return false;
            }
        }
        return true;
    }
}