class Solution {
    public int minPairRemovals(int[] nums) {
        int[] count = new int[101];
        for (int num : nums) {
            count[num]++;
        }
        int maxFreq = 0;
        for (int freq : count) {
            maxFreq = Math.max(maxFreq, freq);
        }
        return nums.length - maxFreq;
    }
}