class Solution {
    public int minDeletions(String s) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }

        Set<Integer> seen = new HashSet<>();
        int deletions = 0;

        for (int i = 0; i < 26; i++) {
            while (freq[i] > 0 && seen.contains(freq[i])) {
                freq[i]--;
                deletions++;
            }
            seen.add(freq[i]);
        }

        return deletions;
    }
}