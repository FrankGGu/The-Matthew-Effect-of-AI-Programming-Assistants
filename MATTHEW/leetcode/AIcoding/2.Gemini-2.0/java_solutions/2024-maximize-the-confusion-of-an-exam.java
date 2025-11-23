class Solution {
    public int maxConsecutiveAnswers(String answerKey, int k) {
        return Math.max(maxConsecutive(answerKey, k, 'T'), maxConsecutive(answerKey, k, 'F'));
    }

    private int maxConsecutive(String answerKey, int k, char ch) {
        int left = 0, right = 0, count = 0, maxLen = 0;
        while (right < answerKey.length()) {
            if (answerKey.charAt(right) != ch) {
                count++;
            }
            while (count > k) {
                if (answerKey.charAt(left) != ch) {
                    count--;
                }
                left++;
            }
            maxLen = Math.max(maxLen, right - left + 1);
            right++;
        }
        return maxLen;
    }
}