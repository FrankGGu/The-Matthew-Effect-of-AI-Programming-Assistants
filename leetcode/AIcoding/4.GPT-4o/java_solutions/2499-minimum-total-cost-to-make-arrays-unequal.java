class Solution {
    public long minimumTotalCost(int[] nums) {
        long cost = 0;
        int n = nums.length;
        int[] freq = new int[100001];

        for (int num : nums) {
            freq[num]++;
        }

        for (int i = 0; i < n; i++) {
            if (freq[nums[i]] > 1) {
                cost += Math.min(nums[i], 1);
                freq[nums[i]]--;
            }
        }

        return cost;
    }
}