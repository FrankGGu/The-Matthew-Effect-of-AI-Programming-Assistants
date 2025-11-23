class Solution {
    public int findMirrorScore(String s) {
        int totalScore = 0;
        for (char c : s.toCharArray()) {
            // For each character 'c', its mirror character's 1-based alphabetical value is calculated.
            // 'a' (0th from 'a') mirrors to 'z' (0th from 'z'), 'b' (1st from 'a') mirrors to 'y' (1st from 'z'), etc.
            // The 1-based value of a character 'x' is (x - 'a' + 1).
            // The mirror character for 'c' is 'z' - (c - 'a').
            // So, the value of the mirror character is ('z' - (c - 'a') - 'a' + 1).
            // This simplifies to ('z' - c + 1).
            totalScore += ('z' - c) + 1;
        }
        return totalScore;
    }
}