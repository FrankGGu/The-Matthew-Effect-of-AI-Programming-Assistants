public class Solution {
    public int maxVowels(String s, int k) {
        int maxCount = 0;
        int currentCount = 0;
        int n = s.length();
        for (int i = 0; i < n; i++) {
            if (i >= k) {
                if (isVowel(s.charAt(i - k))) {
                    currentCount--;
                }
            }
            if (isVowel(s.charAt(i))) {
                currentCount++;
            }
            maxCount = Math.max(maxCount, currentCount);
        }
        return maxCount;
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
}