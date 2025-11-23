class Solution {
    public boolean canConstruct(String s, int k) {
        if (s == null || s.length() == 0) {
            return k == 0;
        }

        if (k > s.length()) {
            return false;
        }

        int[] charCounts = new int[26];
        for (char c : s.toCharArray()) {
            charCounts[c - 'a']++;
        }

        int oddCounts = 0;
        for (int count : charCounts) {
            if (count % 2 != 0) {
                oddCounts++;
            }
        }

        return oddCounts <= k;
    }
}