class Solution {
    public int minSteps(String s, String t) {
        int[] sCount = new int[26];
        int[] tCount = new int[26];

        for (char c : s.toCharArray()) {
            sCount[c - 'a']++;
        }
        for (char c : t.toCharArray()) {
            tCount[c - 'a']++;
        }

        int steps = 0;
        for (int i = 0; i < 26; i++) {
            steps += Math.abs(sCount[i] - tCount[i]);
        }

        return steps;
    }
}