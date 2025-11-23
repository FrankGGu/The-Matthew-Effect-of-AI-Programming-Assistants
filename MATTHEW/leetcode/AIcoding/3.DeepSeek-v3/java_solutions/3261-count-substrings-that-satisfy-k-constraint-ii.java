class Solution {
    public long countSubstrings(String s, int k) {
        int n = s.length();
        long res = 0;
        for (int i = 0; i < n; i++) {
            int[] freq = new int[26];
            int distinct = 0;
            for (int j = i; j < n; j++) {
                char c = s.charAt(j);
                if (freq[c - 'a'] == 0) {
                    distinct++;
                }
                freq[c - 'a']++;
                if (distinct >= k) {
                    res++;
                }
            }
        }
        return res;
    }
}