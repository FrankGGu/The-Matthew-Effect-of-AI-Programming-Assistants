class Solution {
    public int getMaxLen(int[] nums) {
        int maxLength = 0, currentLength = 0, negativeCount = 0;

        for (int num : nums) {
            if (num > 0) {
                currentLength++;
            } else if (num < 0) {
                negativeCount++;
                currentLength++;
            } else {
                currentLength = 0;
                negativeCount = 0;
            }

            if (negativeCount % 2 == 0) {
                maxLength = Math.max(maxLength, currentLength);
            } else {
                int tempLength = currentLength;
                for (int i = 0; i < currentLength; i++) {
                    if (nums[i] < 0) {
                        tempLength = currentLength - i - 1;
                        break;
                    }
                }
                maxLength = Math.max(maxLength, tempLength);
            }
        }

        return maxLength;
    }
}