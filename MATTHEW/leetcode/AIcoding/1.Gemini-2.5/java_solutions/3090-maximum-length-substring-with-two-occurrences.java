class Solution {
    public int maximumLengthSubstring(String s) {
        int[] counts = new int[26];
        int left = 0;
        int maxLength = 0;

        for (int right = 0; right < s.length(); right++) {
            char rightChar = s.charAt(right);
            counts[rightChar - 'a']++;

            while (counts[rightChar - 'a'] > 2) {
                char leftChar = s.charAt(left);
                counts[leftChar - 'a']--;
                left++;
            }
            maxLength = Math.max(maxLength, right - left + 1);
        }

        return maxLength;
    }
}