class Solution {
    public int countSubstrings(String s, int k) {
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            int[] freq = new int[26];
            for (int j = i; j < s.length(); j++) {
                freq[s.charAt(j) - 'a']++;
                if (hasKFreq(freq, k)) {
                    count++;
                }
            }
        }
        return count;
    }

    private boolean hasKFreq(int[] freq, int k) {
        for (int f : freq) {
            if (f == k) {
                return true;
            }
        }
        return false;
    }
}