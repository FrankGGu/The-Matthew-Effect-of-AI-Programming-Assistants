class Solution {
    public long countSubstringsThatSatisfyKConstraintII(String s, int k) {
        if (k <= 0) {
            long n = s.length();
            return n * (n + 1) / 2;
        }

        long countAtMostKMinusOne = countSubstringsWithAtMostDistinct(s, k - 1);

        long n = s.length();
        long totalSubstrings = n * (n + 1) / 2;

        return totalSubstrings - countAtMostKMinusOne;
    }

    private long countSubstringsWithAtMostDistinct(String s, int maxDistinct) {
        if (maxDistinct < 0) {
            return 0;
        }

        long count = 0;
        int left = 0;
        int[] freq = new int[26];
        int distinctCount = 0;

        for (int right = 0; right < s.length(); right++) {
            char rChar = s.charAt(right);
            if (freq[rChar - 'a'] == 0) {
                distinctCount++;
            }
            freq[rChar - 'a']++;

            while (distinctCount > maxDistinct) {
                char lChar = s.charAt(left);
                freq[lChar - 'a']--;
                if (freq[lChar - 'a'] == 0) {
                    distinctCount--;
                }
                left++;
            }
            count += (right - left + 1);
        }
        return count;
    }
}