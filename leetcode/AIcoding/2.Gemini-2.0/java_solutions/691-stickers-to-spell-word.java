import java.util.*;

class Solution {
    public int minStickers(String[] stickers, String target) {
        int n = target.length();
        int[] dp = new int[1 << n];
        Arrays.fill(dp, -1);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            if (dp[mask] == -1) continue;

            for (String sticker : stickers) {
                int newMask = mask;
                int[] stickerCount = new int[26];
                for (char c : sticker.toCharArray()) {
                    stickerCount[c - 'a']++;
                }

                for (int i = 0; i < n; i++) {
                    if ((mask & (1 << i)) == 0) {
                        char c = target.charAt(i);
                        if (stickerCount[c - 'a'] > 0) {
                            stickerCount[c - 'a']--;
                            newMask |= (1 << i);
                        }
                    }
                }

                if (dp[newMask] == -1 || dp[newMask] > dp[mask] + 1) {
                    dp[newMask] = dp[mask] + 1;
                }
            }
        }

        return dp[(1 << n) - 1];
    }
}