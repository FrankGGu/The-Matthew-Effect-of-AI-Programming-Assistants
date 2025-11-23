#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumProfit(vector<int>& prices, int fee, int discount) {
        int n = prices.size();
        vector<int> hold(n, 0);
        vector<int> notHold(n, 0);

        hold[0] = -prices[0];
        notHold[0] = 0;

        for (int i = 1; i < n; ++i) {
            hold[i] = max(hold[i - 1], notHold[i - 1] - prices[i]);
            notHold[i] = max(notHold[i - 1], hold[i - 1] + prices[i] - fee);

            if (i >= 2) {
                notHold[i] = max(notHold[i], hold[i - 2] + prices[i] - discount);
            }
        }

        return notHold[n - 1];
    }
};