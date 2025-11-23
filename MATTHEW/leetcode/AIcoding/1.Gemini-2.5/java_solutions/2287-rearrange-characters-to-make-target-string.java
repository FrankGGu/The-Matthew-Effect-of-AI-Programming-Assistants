class Solution {
    public int rearrangeCharacters(String s, String target) {
        int[] sFreq = new int[26];
        int[] targetFreq = new int[26];

        for (char c : s.toCharArray()) {
            sFreq[c - 'a']++;
        }

        for (char c : target.toCharArray()) {
            targetFreq[c - 'a']++;
        }

        int maxCopies = Integer.MAX_VALUE;

        for (char c : target.toCharArray()) {
            int charIndex = c - 'a';
            if (targetFreq[charIndex] > 0) { // Only consider characters present in target
                maxCopies = Math.min(maxCopies, sFreq[charIndex] / targetFreq[charIndex]);
            }
        }

        return maxCopies;
    }
}