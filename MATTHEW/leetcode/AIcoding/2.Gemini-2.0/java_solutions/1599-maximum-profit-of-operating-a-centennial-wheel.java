class Solution {
    public int minOperationsMaxProfit(int[] customers, int boardingCost, int runningCost) {
        int profit = 0;
        int maxProfit = 0;
        int wait = 0;
        int rounds = 0;
        int ans = -1;

        for (int i = 0; i < customers.length; i++) {
            wait += customers[i];
            int board = Math.min(wait, 4);
            wait -= board;
            profit += board * boardingCost - runningCost;
            rounds++;

            if (profit > maxProfit) {
                maxProfit = profit;
                ans = rounds;
            }
        }

        if (wait > 0) {
            int fullRounds = wait / 4;
            profit += fullRounds * (4 * boardingCost - runningCost);
            rounds += fullRounds;

            if (profit > maxProfit) {
                maxProfit = profit;
                ans = rounds;
            }

            wait %= 4;
            if (wait > 0) {
                rounds++;
                profit += wait * boardingCost - runningCost;
                if (profit > maxProfit) {
                    maxProfit = profit;
                    ans = rounds;
                }
            }
        }

        return ans;
    }
}