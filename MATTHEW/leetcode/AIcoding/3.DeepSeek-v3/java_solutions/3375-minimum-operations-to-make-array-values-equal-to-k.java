class Solution {
    public long minOperations(int[] nums, int k) {
        long operations = 0;
        for (int num : nums) {
            if (num < k) {
                operations += (k - num);
            } else if (num > k) {
                operations += (num - k);
            }
        }
        return operations;
    }
}