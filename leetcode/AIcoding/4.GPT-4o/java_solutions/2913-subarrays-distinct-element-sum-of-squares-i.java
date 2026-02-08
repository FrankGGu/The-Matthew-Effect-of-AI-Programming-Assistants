class Solution {
    public int sumOfSquares(int[] nums) {
        int n = nums.length;
        int mod = 1_000_000_007;
        long result = 0;
        for (int i = 0; i < n; i++) {
            HashSet<Integer> set = new HashSet<>();
            for (int j = i; j < n; j++) {
                set.add(nums[j]);
                result = (result + (long)set.size() * set.size()) % mod;
            }
        }
        return (int) result;
    }
}