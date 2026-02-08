class Solution {
    public int countCompleteSubstrings(String s) {
        int n = s.length();
        int distinctChars = (int) s.chars().distinct().count();
        int count = 0;

        for (int i = 0; i < n; i++) {
            int[] freq = new int[26];
            int uniqueCount = 0;

            for (int j = i; j < n; j++) {
                if (freq[s.charAt(j) - 'a'] == 0) {
                    uniqueCount++;
                }
                freq[s.charAt(j) - 'a']++;

                if (uniqueCount == distinctChars) {
                    count++;
                }
            }
        }

        return count;
    }
}