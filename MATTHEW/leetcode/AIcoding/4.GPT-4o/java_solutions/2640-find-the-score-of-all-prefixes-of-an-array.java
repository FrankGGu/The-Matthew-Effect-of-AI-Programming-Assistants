class Solution {
    public long[] findPrefixScore(int[] nums) {
        long[] result = new long[nums.length];
        long max = 0;
        long sum = 0;

        for (int i = 0; i < nums.length; i++) {
            max = Math.max(max, nums[i]);
            sum += max + nums[i];
            result[i] = sum;
        }

        return result;
    }
}