class Solution {
    public int rearrangeCharacters(String s, String target) {
        int[] sCount = new int[26];
        int[] targetCount = new int[26];

        for (char c : s.toCharArray()) {
            sCount[c - 'a']++;
        }

        for (char c : target.toCharArray()) {
            targetCount[c - 'a']++;
        }

        int minCopies = Integer.MAX_VALUE;
        for (int i = 0; i < 26; i++) {
            if (targetCount[i] > 0) {
                int copies = sCount[i] / targetCount[i];
                if (copies < minCopies) {
                    minCopies = copies;
                }
            }
        }

        return minCopies;
    }
}