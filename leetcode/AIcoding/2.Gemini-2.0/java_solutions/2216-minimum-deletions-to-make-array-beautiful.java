class Solution {
    public int minDeletion(int[] nums) {
        int deletions = 0;
        int n = nums.length;
        int i = 0;
        while (i < n - deletions - 1) {
            if ((i % 2 == 0) && (nums[i] == nums[i + 1])) {
                deletions++;
                for (int j = i; j < n - deletions - 1; j++) {
                    nums[j] = nums[j + 1];
                }
            } else {
                i++;
            }
        }
        if ((n - deletions) % 2 != 0) {
            deletions++;
        }
        return deletions;
    }
}