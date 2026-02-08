class Solution {
    public int minDeletion(int[] nums) {
        int deletions = 0;
        int n = nums.length;
        for (int i = 0; i < n; ) {
            int j = i + 1;
            while (j < n && nums[j] == nums[i]) {
                j++;
                deletions++;
            }
            i = j + 1;
        }
        if ((n - deletions) % 2 != 0) {
            deletions++;
        }
        return deletions;
    }
}