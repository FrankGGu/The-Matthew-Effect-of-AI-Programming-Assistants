class Solution {
    public int minimumDeletions(String s, int k) {
        int n = s.length();
        if (n == 0) {
            return 0;
        }

        int[] freq = new int[26];
        int distinctCount = 0;
        int maxLen = 0;
        int left = 0;

        for (int right = 0; right < n; right++) {
            char c = s.charAt(right);
            if (freq[c - 'a'] == 0) {
                distinctCount++;
            }
            freq[c - 'a']++;

            while (distinctCount > k) {
                char d = s.charAt(left);
                freq[d - 'a']--;
                if (freq[d - 'a'] == 0) {
                    distinctCount--;
                }
                left++;
            }
            maxLen = Math.max(maxLen, right - left + 1);
        }

        return n - maxLen;
    }
}