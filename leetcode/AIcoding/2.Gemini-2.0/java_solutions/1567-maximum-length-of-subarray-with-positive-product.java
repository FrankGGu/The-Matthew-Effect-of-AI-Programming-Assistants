class Solution {
    public int getMaxLen(int[] nums) {
        int pos = 0, neg = 0, maxLen = 0;
        for (int num : nums) {
            if (num == 0) {
                pos = 0;
                neg = 0;
            } else if (num > 0) {
                pos++;
                neg = (neg == 0) ? 0 : neg + 1;
            } else {
                int temp = pos;
                pos = (neg == 0) ? 0 : neg + 1;
                neg = temp + 1;
            }
            maxLen = Math.max(maxLen, pos);
        }
        return maxLen;
    }
}