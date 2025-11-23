class Solution {
    public int minStickers(String[] stickers, String target) {
        int n = target.length();
        int[] dp = new int[1 << n];
        Arrays.fill(dp, -1);
        dp[0] = 0;

        for (int state = 0; state < (1 << n); state++) {
            if (dp[state] == -1) continue;
            for (String sticker : stickers) {
                int nextState = state;
                int[] count = new int[26];
                for (char c : sticker.toCharArray()) {
                    count[c - 'a']++;
                }
                for (int i = 0; i < n; i++) {
                    if (((state >> i) & 1) == 1) continue;
                    char c = target.charAt(i);
                    if (count[c - 'a'] > 0) {
                        nextState |= (1 << i);
                        count[c - 'a']--;
                    }
                }
                if (dp[nextState] == -1 || dp[nextState] > dp[state] + 1) {
                    dp[nextState] = dp[state] + 1;
                }
            }
        }
        return dp[(1 << n) - 1];
    }
}