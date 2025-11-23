class Solution {
    public int minOperations(int[] nums, int k) {
        int count = 0;
        int collected = 0;
        boolean[] found = new boolean[k + 1];

        for (int i = nums.length - 1; i >= 0; i--) {
            count++;
            if (nums[i] <= k && !found[nums[i]]) {
                found[nums[i]] = true;
                collected++;
            }
            if (collected == k) {
                break;
            }
        }
        return count;
    }
}