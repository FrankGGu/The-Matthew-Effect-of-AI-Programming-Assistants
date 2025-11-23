class Solution {
    public boolean checkDistances(String s, int[] distance) {
        int[] firstOccurrence = new int[26];
        for (int i = 0; i < 26; i++) {
            firstOccurrence[i] = -1;
        }

        for (int i = 0; i < s.length(); i++) {
            int charIndex = s.charAt(i) - 'a';
            if (firstOccurrence[charIndex] == -1) {
                firstOccurrence[charIndex] = i;
            } else {
                int dist = i - firstOccurrence[charIndex] - 1;
                if (dist != distance[charIndex]) {
                    return false;
                }
            }
        }

        return true;
    }
}