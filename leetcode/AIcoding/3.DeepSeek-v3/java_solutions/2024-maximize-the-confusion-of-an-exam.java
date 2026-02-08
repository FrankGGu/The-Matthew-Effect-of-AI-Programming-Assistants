class Solution {
    public int maxConsecutiveAnswers(String answerKey, int k) {
        return Math.max(getMaxConsecutive(answerKey, k, 'T'), getMaxConsecutive(answerKey, k, 'F'));
    }

    private int getMaxConsecutive(String s, int k, char target) {
        int left = 0;
        int maxLen = 0;
        int count = 0;

        for (int right = 0; right < s.length(); right++) {
            if (s.charAt(right) != target) {
                count++;
            }

            while (count > k) {
                if (s.charAt(left) != target) {
                    count--;
                }
                left++;
            }

            maxLen = Math.max(maxLen, right - left + 1);
        }

        return maxLen;
    }
}