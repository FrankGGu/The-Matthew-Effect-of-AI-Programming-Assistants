import java.util.Arrays;

class Solution {
    public int minimumWords(String target, String[] words) {
        int n = target.length();
        int m = words.length;

        int[] word_masks = new int[m];
        for (int k = 0; k < m; k++) {
            int mask = 0;
            for (char c : words[k].toCharArray()) {
                mask |= (1 << (c - 'a'));
            }
            word_masks[k] = mask;
        }

        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            for (int j = 0; j < i; j++) {
                if (dp[j] == Integer.MAX_VALUE) {
                    continue;
                }

                int required_present_mask = 0;
                int required_absent_mask = 0;

                for (int k = j; k < i; k++) {
                    char c = target.charAt(k);
                    if (Character.isLowerCase(c)) {
                        required_present_mask |= (1 << (c - 'a'));
                    } else {
                        required_absent_mask |= (1 << (Character.toLowerCase(c) - 'a'));
                    }
                }

                boolean can_form_sub_with_one_word = false;
                for (int k = 0; k < m; k++) {
                    int current_word_mask = word_masks[k];

                    if (((current_word_mask & required_present_mask) == required_present_mask) &&
                        ((current_word_mask & required_absent_mask) == 0)) {
                        can_form_sub_with_one_word = true;
                        break;
                    }
                }

                if (can_form_sub_with_one_word) {
                    dp[i] = Math.min(dp[i], dp[j] + 1);
                }
            }
        }

        return dp[n] == Integer.MAX_VALUE ? -1 : dp[n];
    }
}