class Solution {
    public long countSubstrings(String s, char c) {
        long count = 0;
        long occurrences = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == c) {
                occurrences++;
                count += occurrences;
            }
        }
        return count;
    }
}