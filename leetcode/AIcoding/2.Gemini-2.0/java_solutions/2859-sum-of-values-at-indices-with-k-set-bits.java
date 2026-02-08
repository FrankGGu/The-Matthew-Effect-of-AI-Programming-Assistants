class Solution {
    public int sumIndicesWithKSetBits(List<Integer> nums, int k) {
        int sum = 0;
        for (int i = 0; i < nums.size(); i++) {
            int setBits = Integer.bitCount(i);
            if (setBits == k) {
                sum += nums.get(i);
            }
        }
        return sum;
    }
}