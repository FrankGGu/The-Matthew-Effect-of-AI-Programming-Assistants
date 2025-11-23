class Solution {
    public int countGoodPairs(int[] nums) {
        int n = nums.length;
        long[] count = new long[100001];
        long result = 0;

        for (int num : nums) {
            result += count[num]++;
        }

        return (int) result;
    }
}