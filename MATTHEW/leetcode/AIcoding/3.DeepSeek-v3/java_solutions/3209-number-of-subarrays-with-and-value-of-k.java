class Solution {
    public int countSubarraysWithAND(int[] nums, int k) {
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            int currentAnd = nums[i];
            if (currentAnd == k) {
                count++;
            }
            for (int j = i + 1; j < nums.length; j++) {
                currentAnd &= nums[j];
                if (currentAnd == k) {
                    count++;
                } else if (currentAnd < k) {
                    break;
                }
            }
        }
        return count;
    }
}