class Solution {
    public int countSubstrings(String s, int k) {
        int n = s.length();
        int count = 0;
        for (int i = 0; i < n; i++) {
            int distinct = 0;
            boolean[] seen = new boolean[26];
            for (int j = i; j < n; j++) {
                char c = s.charAt(j);
                if (!seen[c - 'a']) {
                    distinct++;
                    seen[c - 'a'] = true;
                }
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