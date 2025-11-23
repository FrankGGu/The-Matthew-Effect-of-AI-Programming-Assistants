class Solution {
    public int countSubstrings(String s, int k) {
        int n = s.length();
        int result = 0;

        for (int i = 0; i < n; i++) {
            int[] count = new int[26];
            int uniqueChars = 0;

            for (int j = i; j < n; j++) {
                if (count[s.charAt(j) - 'a'] == 0) {
                    uniqueChars++;
                }
                count[s.charAt(j) - 'a']++;

                if (uniqueChars > k) {
                    break;
                }
                result++;
            }
        }
        return result;
    }
}