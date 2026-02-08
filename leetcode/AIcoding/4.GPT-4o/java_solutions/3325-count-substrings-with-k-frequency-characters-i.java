class Solution {
    public int countKSubstrings(String s, int k) {
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            int[] freq = new int[26];
            int uniqueCount = 0;
            for (int j = i; j < s.length(); j++) {
                if (freq[s.charAt(j) - 'a'] == 0) uniqueCount++;
                freq[s.charAt(j) - 'a']++;
                if (uniqueCount == k) count++;
                else if (uniqueCount > k) break;
            }
        }
        return count;
    }
}