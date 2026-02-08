#include <vector>

using namespace std;

class Solution {
public:
    int maxProfit(vector<int>& prices, int fee) {
        int n = prices.size();
        if (n == 0) return 0;

        int buy = -prices[0];
        int sell = 0;

        for (int i = 1; i < n; ++i) {
            int prev_buy = buy;
            buy = max(buy, sell - prices[i]);
            sell = max(sell, prev_buy + prices[i] - fee);
        }

        return sell;
    }
};