class Solution {
    public int countSubstrings(String s, int k) {
        int n = s.length();
        int count = 0;

        for (int i = 0; i < n; i++) {
            int[] freq = new int[26];
            int uniqueCount = 0;

            for (int j = i; j < n; j++) {
                if (freq[s.charAt(j) - 'a'] == 0) {
                    uniqueCount++;
                }
                freq[s.charAt(j) - 'a']++;

                if (uniqueCount > k) {
                    break;
                }
                count++;
            }
        }
        return count;
    }
}