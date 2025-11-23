class Solution {
    public long countSubstrings(String s, int k) {
        long count = 0;
        int[] freq = new int[26];
        int distinctCount = 0;
        int left = 0;

        for (int right = 0; right < s.length(); right++) {
            char charRight = s.charAt(right);

            if (freq[charRight - 'a'] == 0) {
                distinctCount++;
            }
            freq[charRight - 'a']++;

            while (distinctCount > k) {
                char charLeft = s.charAt(left);
                freq[charLeft - 'a']--;
                if (freq[charLeft - 'a'] == 0) {
                    distinctCount--;
                }
                left++;
            }
            count += (right - left + 1);
        }
        return count;
    }
}