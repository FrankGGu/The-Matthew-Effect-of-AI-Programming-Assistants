class Solution {
    public int sumIndicesWithKSetBits(List<Integer> nums, int k) {
        int totalSum = 0;
        for (int i = 0; i < nums.size(); i++) {
            if (Integer.bitCount(i) == k) {
                totalSum += nums.get(i);
            }
        }
        return totalSum;
    }
}