class Solution {
    public int findPermutationDifference(String s, String t) {
        int[] sCharIndices = new int[256];

        for (int i = 0; i < s.length(); i++) {
            sCharIndices[s.charAt(i)] = i;
        }

        int totalDifference = 0;

        for (int i = 0; i < t.length(); i++) {
            char currentCharInT = t.charAt(i);
            int indexInS = sCharIndices[currentCharInT];
            int indexInT = i;
            totalDifference += Math.abs(indexInS - indexInT);
        }

        return totalDifference;
    }
}