class Solution {
    public int maxConsecutiveAnswers(String answerKey, int k) {
        int left = 0, right = 0, maxCount = 0, maxLength = 0;
        int[] count = new int[2];

        while (right < answerKey.length()) {
            count[answerKey.charAt(right) - 'T']++;
            while (Math.min(count[0], count[1]) > k) {
                count[answerKey.charAt(left) - 'T']--;
                left++;
            }
            maxLength = Math.max(maxLength, right - left + 1);
            right++;
        }
        return maxLength;
    }
}