class Solution {
    public boolean checkDistances(String s, int[] distance) {
        int[] firstOccurrence = new int[26];
        for (int i = 0; i < 26; i++) {
            firstOccurrence[i] = -1;
        }

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            int charIndex = c - 'a';

            if (firstOccurrence[charIndex] == -1) {
                firstOccurrence[charIndex] = i;
            } else {
                int currentDistance = i - firstOccurrence[charIndex] - 1;
                if (currentDistance != distance[charIndex]) {
                    return false;
                }
            }
        }

        return true;
    }
}