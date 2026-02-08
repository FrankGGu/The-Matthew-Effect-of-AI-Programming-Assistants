class Solution {
    public int maxConsecutiveAnswers(String answerKey, int k) {
        return Math.max(getMaxLength(answerKey, k, 'T'), getMaxLength(answerKey, k, 'F'));
    }

    private int getMaxLength(String answerKey, int k, char targetChar) {
        int n = answerKey.length();
        int left = 0;
        int flipCount = 0; 
        int maxWindowSize = 0;

        for (int right = 0; right < n; right++) {
            if (answerKey.charAt(right) != targetChar) {
                flipCount++;
            }

            while (flipCount > k) {
                if (answerKey.charAt(left) != targetChar) {
                    flipCount--; 
                }
                left++;
            }

            maxWindowSize = Math.max(maxWindowSize, right - left + 1);
        }
        return maxWindowSize;
    }
}