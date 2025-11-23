class Solution {
    public int minStickers(String[] stickers, String target) {
        int n = target.length();
        int[] dp = new int[1 << n];
        Arrays.fill(dp, -1);
        dp[0] = 0;

        for (int state = 0; state < (1 << n); state++) {
            if (dp[state] == -1) continue;
            for (String sticker : stickers) {
                int now = state;
                int[] cnt = new int[26];
                for (char c : sticker.toCharArray()) {
                    cnt[c - 'a']++;
                }
                for (int i = 0; i < n; i++) {
                    if (((now >> i) & 1) == 1) continue;
                    char c = target.charAt(i);
                    if (cnt[c - 'a'] > 0) {
                        cnt[c - 'a']--;
                        now |= 1 << i;
                    }
                }
                if (dp[now] == -1 || dp[now] > dp[state] + 1) {
                    dp[now] = dp[state] + 1;
                }
            }
        }
        return dp[(1 << n) - 1];
    }
}