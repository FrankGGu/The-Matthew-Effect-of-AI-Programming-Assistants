class Solution {
    public int maxFreq(String s, int maxLetters, int minSize, int maxSize) {
        Map<String, Integer> substringCount = new HashMap<>();
        int maxOccurrences = 0;

        for (int i = 0; i <= s.length() - minSize; i++) {
            String substring = s.substring(i, i + minSize);
            if (isValidSubstring(substring, maxLetters)) {
                int count = substringCount.getOrDefault(substring, 0) + 1;
                substringCount.put(substring, count);
                maxOccurrences = Math.max(maxOccurrences, count);
            }
        }

        return maxOccurrences;
    }

    private boolean isValidSubstring(String s, int maxLetters) {
        Set<Character> uniqueChars = new HashSet<>();
        for (char c : s.toCharArray()) {
            uniqueChars.add(c);
            if (uniqueChars.size() > maxLetters) {
                return false;
            }
        }
        return true;
    }
}