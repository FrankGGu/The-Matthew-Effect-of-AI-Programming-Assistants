class Solution {
    public int countCompleteSubstrings(String word, int k) {
        int n = word.length();
        int res = 0;
        for (int i = 0; i < n; ) {
            int start = i;
            i++;
            while (i < n && Math.abs(word.charAt(i) - word.charAt(i - 1)) <= 2) {
                i++;
            }
            res += helper(word.substring(start, i), k);
        }
        return res;
    }

    private int helper(String s, int k) {
        int res = 0;
        for (int unique = 1; unique <= 26 && unique * k <= s.length(); unique++) {
            int[] count = new int[26];
            int left = 0;
            int validCount = 0;
            for (int right = 0; right < s.length(); right++) {
                char c = s.charAt(right);
                count[c - 'a']++;
                if (count[c - 'a'] == k) {
                    validCount++;
                }
                if (count[c - 'a'] == k + 1) {
                    validCount--;
                }
                while (count[c - 'a'] > k) {
                    char leftChar = s.charAt(left);
                    if (count[leftChar - 'a'] == k) {
                        validCount--;
                    }
                    count[leftChar - 'a']--;
                    if (count[leftChar - 'a'] == k) {
                        validCount++;
                    }
                    left++;
                }
                if (validCount == unique) {
                    res++;
                }
            }
        }
        return res;
    }
}