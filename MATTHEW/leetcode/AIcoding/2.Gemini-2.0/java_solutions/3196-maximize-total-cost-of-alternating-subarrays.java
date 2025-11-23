class Solution {
    public long maxAlternatingSum(int[] nums) {
        long even = nums[0];
        long odd = 0;
        for (int i = 1; i < nums.length; i++) {
            long newEven = Math.max(even, odd + nums[i]);
            long newOdd = Math.max(odd, even - nums[i]);
            even = newEven;
            odd = newOdd;
        }
        return even;
    }
}