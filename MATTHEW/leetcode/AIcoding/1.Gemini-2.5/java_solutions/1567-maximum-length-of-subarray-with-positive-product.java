class Solution {
    public int getMaxLen(int[] nums) {
        int maxLen = 0;
        int positiveLen = 0; // maximum length of subarray ending at current position with positive product
        int negativeLen = 0; // maximum length of subarray ending at current position with negative product

        for (int num : nums) {
            if (num == 0) {
                positiveLen = 0;
                negativeLen = 0;
            } else if (num > 0) {
                positiveLen++;
                if (negativeLen > 0) {
                    negativeLen++;
                } else {
                    negativeLen = 0;
                }
            } else { // num < 0
                int prevPositiveLen = positiveLen;
                positiveLen = (negativeLen > 0) ? negativeLen + 1 : 0;
                negativeLen = prevPositiveLen + 1;
            }
            maxLen = Math.max(maxLen, positiveLen);
        }

        return maxLen;
    }
}