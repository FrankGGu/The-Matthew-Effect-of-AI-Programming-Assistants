class Solution {
    public int countPairs(int[] nums, int low, int high) {
        return countPairsWithXOR(nums, high) - countPairsWithXOR(nums, low - 1);
    }

    private int countPairsWithXOR(int[] nums, int target) {
        int count = 0;
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if ((nums[i] ^ nums[j]) <= target) {
                    count++;
                }
            }
        }
        return count;
    }
}