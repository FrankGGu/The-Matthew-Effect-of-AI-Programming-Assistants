class Solution {
    public int maxVowels(String s, int k) {
        int maxCount = 0;
        int currentCount = 0;
        String vowels = "aeiou";

        for (int i = 0; i < s.length(); i++) {
            if (vowels.indexOf(s.charAt(i)) != -1) {
                currentCount++;
            }
            if (i >= k) {
                if (vowels.indexOf(s.charAt(i - k)) != -1) {
                    currentCount--;
                }
            }
            if (i >= k - 1) {
                maxCount = Math.max(maxCount, currentCount);
            }
        }

        return maxCount;
    }
}