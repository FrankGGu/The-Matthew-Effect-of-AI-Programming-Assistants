class Solution {
    public int maximumLengthSubstring(String s) {
        int maxLength = 0;
        Map<Character, Integer> charCount = new HashMap<>();

        for (int left = 0, right = 0; right < s.length(); right++) {
            charCount.put(s.charAt(right), charCount.getOrDefault(s.charAt(right), 0) + 1);

            while (charCount.size() > 2) {
                char leftChar = s.charAt(left);
                charCount.put(leftChar, charCount.get(leftChar) - 1);
                if (charCount.get(leftChar) == 0) {
                    charCount.remove(leftChar);
                }
                left++;
            }
            maxLength = Math.max(maxLength, right - left + 1);
        }

        return maxLength;
    }
}