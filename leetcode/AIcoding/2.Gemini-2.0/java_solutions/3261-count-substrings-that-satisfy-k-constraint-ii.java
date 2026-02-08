class Solution {
    public long countSubstrings(String s, int k) {
        int n = s.length();
        long count = 0;

        for (int i = 0; i < n; i++) {
            int[] freq = new int[26];
            int distinct = 0;
            for (int j = i; j < n; j++) {
                int index = s.charAt(j) - 'a';
                if (freq[index] == 0) {
                    distinct++;
                }
                freq[index]++;
                if (distinct == k) {
                    count++;
                } else if (distinct > k) {
                    break;
                }
            }
        }
        return count;
    }
}