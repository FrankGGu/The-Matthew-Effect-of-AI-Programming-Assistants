class Solution {
    public long appealSum(String s) {
        long totalAppeal = 0;
        int n = s.length();
        int[] lastSeen = new int[26];

        for (int i = 0; i < n; i++) {
            int charIndex = s.charAt(i) - 'a';
            lastSeen[charIndex] = i + 1;
            for (int j = 0; j < 26; j++) {
                totalAppeal += lastSeen[j];
            }
        }

        return totalAppeal;
    }
}