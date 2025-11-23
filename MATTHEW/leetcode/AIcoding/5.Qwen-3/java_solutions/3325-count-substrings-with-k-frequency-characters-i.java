public class Solution {
    public int kFrequencySubstrings(String s, int k) {
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            int[] freq = new int[26];
            int unique = 0;
            for (int j = i; j < s.length(); j++) {
                char c = s.charAt(j);
                if (freq[c - 'a'] == 0) {
                    unique++;
                }
                freq[c - 'a']++;
                if (freq[c - 'a'] == k) {
                    count++;
                }
            }
        }
        return count;
    }
}