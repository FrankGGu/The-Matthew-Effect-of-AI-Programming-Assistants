class Solution {
public:
    int minOperationsMaxProfit(vector<int>& customers, int boardingCost, int runningCost) {
        int profit = 0, maxProfit = 0, ans = -1, waiting = 0, rotations = 0;
        for (int i = 0; i < customers.size() || waiting > 0; ++i) {
            if (i < customers.size()) {
                waiting += customers[i];
            }
            int boarded = min(4, waiting);
            waiting -= boarded;
            rotations++;
            profit += boarded * boardingCost - runningCost;
            if (profit > maxProfit) {
                maxProfit = profit;
                ans = rotations;
            }
        }
        return ans;
    }
};