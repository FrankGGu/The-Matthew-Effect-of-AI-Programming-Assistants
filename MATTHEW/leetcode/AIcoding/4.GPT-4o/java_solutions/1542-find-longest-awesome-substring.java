class Solution {
    public int longestAwesome(String s) {
        int n = s.length();
        int[] maskIndex = new int[1024];
        Arrays.fill(maskIndex, -1);
        maskIndex[0] = 0;

        int maxLength = 0;
        int mask = 0;

        for (int i = 0; i < n; i++) {
            mask ^= 1 << (s.charAt(i) - '0');
            for (int j = 0; j < 2; j++) {
                int newMask = mask ^ (1 << j);
                if (maskIndex[newMask] != -1) {
                    maxLength = Math.max(maxLength, i + 1 - maskIndex[newMask]);
                }
            }
            if (maskIndex[mask] == -1) {
                maskIndex[mask] = i + 1;
            }
        }

        return maxLength;
    }
}