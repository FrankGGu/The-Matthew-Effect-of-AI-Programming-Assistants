class Solution {
    public int countMonotonicPairs(int[] nums) {
        int count = 0, n = nums.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = i + 1; j < n; j++) {
                if ((nums[i] <= nums[j]) || (nums[i] >= nums[j])) {
                    count++;
                }
            }
        }
        return count;
    }
}