class Solution {
    public int minSteps(String s, String t) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        for (char c : t.toCharArray()) {
            count[c - 'a']--;
        }
        int steps = 0;
        for (int c : count) {
            if (c > 0) {
                steps += c;
            }
        }
        return steps;
    }
}