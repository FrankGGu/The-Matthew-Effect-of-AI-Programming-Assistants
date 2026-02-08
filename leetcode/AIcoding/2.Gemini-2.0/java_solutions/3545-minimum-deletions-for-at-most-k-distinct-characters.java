class Solution {
    public int minDeletions(String s, int k) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }

        int[] count = new int[s.length() + 1];
        for (int i = 0; i < 26; i++) {
            if (freq[i] > 0) {
                count[freq[i]]++;
            }
        }

        int deletions = 0;
        for (int i = s.length(); i > 0; i--) {
            if (count[i] > 0) {
                while (count[i] > 1 && i > 0) {
                    deletions++;
                    count[i]--;
                    int j = i - 1;
                    while (j > 0 && count[j] > 0) {
                        j--;
                    }
                    count[j]++;
                }

                if (count[i] > 1 && i == 0) {
                    deletions += count[i] - 1;
                }
            }
        }

        return deletions;
    }
}