class Solution {
    public int[] getMaximumXor(int[] nums, int maximumBit) {
        int n = nums.length;
        int[] answer = new int[n];
        int currentXorSum = 0;
        int maxVal = (1 << maximumBit) - 1;

        for (int i = 0; i < n; i++) {
            currentXorSum ^= nums[i];
            answer[n - 1 - i] = currentXorSum ^ maxVal;
        }

        return answer;
    }
}