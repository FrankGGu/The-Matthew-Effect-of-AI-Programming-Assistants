class Solution {
    public int minimumOperationsToMakeEqual(int x, int y) {
        if (x <= y) {
            return y - x;
        }

        int[] dp = new int[x - y + 1];
        dp[0] = 0;

        for (int i = 1; i <= x - y; i++) {
            dp[i] = i;
        }

        for (int i = 1; i <= x - y; i++) {
            int val = x - y - i;
            if (x % 5 == 0) {
                dp[i] = Math.min(dp[i], 1 + dp[Math.abs(x - 5 - y)]);
                dp[i] = Math.min(dp[i], 1 + dp[Math.abs(x + 5 - y)]);
            }
            if (x % 11 == 0) {
                dp[i] = Math.min(dp[i], 1 + dp[Math.abs(x - 11 - y)]);
                dp[i] = Math.min(dp[i], 1 + dp[Math.abs(x + 11 - y)]);
            }
            if((x - i + y) % 5 == 0) {
                 dp[i] = Math.min(dp[i], 1 + dp[Math.abs((x - i + y) - 5 - y)]);
            }
             if((x - i + y) % 11 == 0) {
                 dp[i] = Math.min(dp[i], 1 + dp[Math.abs((x - i + y) - 11 - y)]);
            }

            if((x - i + y) % 5 == 0) {
                 dp[i] = Math.min(dp[i], 1 + dp[Math.abs((x - i + y) + 5 - y)]);
            }
             if((x - i + y) % 11 == 0) {
                 dp[i] = Math.min(dp[i], 1 + dp[Math.abs((x - i + y) + 11 - y)]);
            }

            if (x - i + y == y) {
                dp[i] = Math.min(dp[i], i);
            }
        }

        int ans = x - y;

        int curr = x;
        int ops = 0;

        while(curr > y) {

            int diff5 = Integer.MAX_VALUE;
            int diff11 = Integer.MAX_VALUE;
            if(curr > 0) {
                 diff5 = Math.abs(curr - 5 - y) + 1;
                 diff11 = Math.abs(curr - 11 - y) + 1;
            }

            int diff5add = Integer.MAX_VALUE;
            int diff11add = Integer.MAX_VALUE;

            diff5add = Math.abs(curr + 5 - y) + 1;
            diff11add = Math.abs(curr + 11 - y) + 1;
            int diff = Math.abs(curr - 1 - y) + 1;

            if(curr > y) {
                if(curr % 5 == 0) {
                    ans = Math.min(ans, diff5 + ops);
                } else {

                }
                if(curr % 11 == 0) {
                    ans = Math.min(ans, diff11 + ops);
                } else {

                }

                ans = Math.min(ans, Math.abs(curr - y));
            }

           if(curr % 5 == 0 || curr % 11 == 0){
               if(curr % 5 == 0) {
                   ans = Math.min(ans, Math.abs(curr - 5 - y) + 1 );
                   ans = Math.min(ans, Math.abs(curr + 5 - y) + 1);

               }

               if(curr % 11 == 0) {
                     ans = Math.min(ans, Math.abs(curr - 11 - y) + 1);
                     ans = Math.min(ans, Math.abs(curr + 11 - y) + 1);
               }
               break;

           } else {
               curr = curr - 1;
               ops++;
           }

        }

        return ans;

    }
}