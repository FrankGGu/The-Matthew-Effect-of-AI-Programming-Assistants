class Solution {
public:
    int closestCost(vector<int>& baseCosts, vector<int>& toppingCosts, int target) {
        int closest = INT_MAX;
        int minDiff = INT_MAX;

        for (int base : baseCosts) {
            vector<int> dp(10001, INT_MAX);
            dp[0] = 0;

            for (int topping : toppingCosts) {
                for (int j = 10000; j >= 0; --j) {
                    if (dp[j] != INT_MAX) {
                        for (int k = 1; k <= 2; ++k) {
                            int newCost = j + topping * k;
                            if (newCost <= 10000) {
                                dp[newCost] = min(dp[newCost], dp[j] + topping * k);
                            }
                        }
                    }
                }
            }

            for (int i = base; i <= 10000; ++i) {
                if (dp[i - base] != INT_MAX) {
                    int diff = abs(target - i);
                    if (diff < minDiff || (diff == minDiff && i < closest)) {
                        minDiff = diff;
                        closest = i;
                    }
                }
            }
        }

        return closest;
    }
};