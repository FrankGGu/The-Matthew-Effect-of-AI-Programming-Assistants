class Solution {
    public int beautySum(String s) {
        int totalBeauty = 0;
        int n = s.length();

        for (int i = 0; i < n; i++) {
            int[] freq = new int[26];
            for (int j = i; j < n; j++) {
                freq[s.charAt(j) - 'a']++;

                int maxFreq = 0;
                int minFreq = Integer.MAX_VALUE;

                for (int k = 0; k < 26; k++) {
                    if (freq[k] > 0) {
                        maxFreq = Math.max(maxFreq, freq[k]);
                        minFreq = Math.min(minFreq, freq[k]);
                    }
                }
                // If minFreq is still Integer.MAX_VALUE, it means no characters are present yet,
                // which only happens for empty string or before the first character, but our loop
                // ensures at least one character is added.
                // So minFreq will always be <= maxFreq.
                totalBeauty += (maxFreq - minFreq);
            }
        }
        return totalBeauty;
    }
}