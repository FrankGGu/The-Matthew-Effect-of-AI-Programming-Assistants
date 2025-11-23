class Solution {
    public int minBeautifulPartitions(String s, int k) {
        int n = s.length();
        if (s.charAt(0) != '2' && s.charAt(0) != '3' && s.charAt(0) != '5' && s.charAt(0) != '7') {
            return -1;
        }
        if (Integer.parseInt(s) % k != 0 && s.length() > 1) {
            return -1;
        }

        boolean[] prime = new boolean[1001];
        for (int i = 2; i <= 1000; i++) {
            prime[i] = true;
        }
        for (int i = 2; i * i <= 1000; i++) {
            if (prime[i]) {
                for (int j = i * i; j <= 1000; j += i) {
                    prime[j] = false;
                }
            }
        }

        int[] dp = new int[n + 1];
        dp[0] = 0;
        for (int i = 1; i <= n; i++) {
            dp[i] = Integer.MAX_VALUE;
            for (int j = 1; j <= i; j++) {
                String sub = s.substring(i - j, i);
                if (sub.charAt(0) != '2' && sub.charAt(0) != '3' && sub.charAt(0) != '5' && sub.charAt(0) != '7') {
                    continue;
                }
                if (j > 1 && sub.charAt(0) == '0') continue;
                int num = Integer.parseInt(sub);
                if (num >= k && num <= 1000 && prime[num] && dp[i - j] != Integer.MAX_VALUE) {
                    dp[i] = Math.min(dp[i], dp[i - j] + 1);
                }
            }
        }

        return dp[n] == Integer.MAX_VALUE ? -1 : dp[n];
    }
}