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

        for (int i = 0; i < 26; i++) {
            if (targetFreq[i] > 0) {
                int possibleCopies = sFreq[i] / targetFreq[i];
                maxCopies = Math.min(maxCopies, possibleCopies);
            }
        }

        return maxCopies;
    }
}