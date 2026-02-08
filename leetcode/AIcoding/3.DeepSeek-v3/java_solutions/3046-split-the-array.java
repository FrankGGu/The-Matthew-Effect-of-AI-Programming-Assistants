class Solution {
    public boolean isPossibleToSplit(int[] nums) {
        if (nums.length % 2 != 0) {
            return false;
        }
        int[] freq = new int[101];
        for (int num : nums) {
            freq[num]++;
            if (freq[num] > 2) {
                return false;
            }
        }
        return true;
    }
}