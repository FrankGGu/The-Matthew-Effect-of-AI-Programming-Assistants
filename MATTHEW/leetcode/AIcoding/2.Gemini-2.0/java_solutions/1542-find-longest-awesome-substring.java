class Solution {
    public int longestAwesome(String s) {
        int n = s.length();
        int[] firstOccurrence = new int[1 << 10];
        for (int i = 0; i < (1 << 10); i++) {
            firstOccurrence[i] = n;
        }
        firstOccurrence[0] = -1;
        int maxLen = 0;
        int mask = 0;
        for (int i = 0; i < n; i++) {
            mask ^= (1 << (s.charAt(i) - '0'));
            if (firstOccurrence[mask] == n) {
                firstOccurrence[mask] = i;
            }
            maxLen = Math.max(maxLen, i - firstOccurrence[mask]);
            for (int j = 0; j < 10; j++) {
                int tempMask = mask ^ (1 << j);
                if (firstOccurrence[tempMask] != n) {
                    maxLen = Math.max(maxLen, i - firstOccurrence[tempMask]);
                }
            }
        }
        return maxLen;
    }
}