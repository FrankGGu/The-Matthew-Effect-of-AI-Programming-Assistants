public class Solution {
    public int maxConfusion(String answerKey, int k) {
        return Math.max(maxConsecutiveCharacters(answerKey, k, 'F'), maxConsecutiveCharacters(answerKey, k, 'T'));
    }

    private int maxConsecutiveCharacters(String s, int k, char target) {
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