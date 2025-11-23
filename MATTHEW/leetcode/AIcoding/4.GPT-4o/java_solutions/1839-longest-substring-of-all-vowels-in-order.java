class Solution {
    public int longestVowelSubstring(String s) {
        int maxLength = 0;
        String vowels = "aeiou";
        int n = s.length();

        for (int i = 0; i < n; i++) {
            int length = 0;
            int vowelIndex = 0;
            while (i < n && vowelIndex < 5 && s.charAt(i) == vowels.charAt(vowelIndex)) {
                length++;
                vowelIndex++;
                i++;
            }
            maxLength = Math.max(maxLength, length);
        }

        return maxLength;
    }
}