class Solution {
    public int minSteps(String s, String t) {
        int[] countS = new int[26];
        int[] countT = new int[26];

        for (char c : s.toCharArray()) {
            countS[c - 'a']++;
        }

        for (char c : t.toCharArray()) {
            countT[c - 'a']++;
        }

        int steps = 0;
        for (int i = 0; i < 26; i++) {
            steps += Math.abs(countS[i] - countT[i]);
        }

        return steps;
    }
}