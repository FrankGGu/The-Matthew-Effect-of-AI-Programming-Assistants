class Solution {
    public int maximumStrongPairXOR(int[] nums) {
        int max = 0;
        for (int num : nums) {
            max = Math.max(max, num);
        }
        return max;
    }
}