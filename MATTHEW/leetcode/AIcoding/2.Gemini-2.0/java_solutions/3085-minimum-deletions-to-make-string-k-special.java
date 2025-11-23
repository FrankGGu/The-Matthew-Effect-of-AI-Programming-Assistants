class Solution {
    public int minDeletions(String s, int k) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }

        int[] counts = new int[s.length() + 1];
        for (int f : freq) {
            if (f > 0) {
                counts[f]++;
            }
        }

        int deletions = 0;
        for (int i = s.length(); i > 0; i--) {
            if (counts[i] > k) {
                deletions += (counts[i] - k);
                counts[i - 1] += (counts[i] - k);
            }
        }

        return deletions;
    }
}