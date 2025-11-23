class Solution {
    public int findPermutationDifference(String s, String t) {
        int[] sIndices = new int[26];
        int[] tIndices = new int[26];

        for (int i = 0; i < s.length(); i++) {
            sIndices[s.charAt(i) - 'a'] = i;
            tIndices[t.charAt(i) - 'a'] = i;
        }

        int difference = 0;
        for (int i = 0; i < 26; i++) {
            difference += Math.abs(sIndices[i] - tIndices[i]);
        }

        return difference;
    }
}