class Solution {
public:
    long long minimumMoney(vector<vector<int>>& transactions) {
        long long total_loss = 0;
        int max_cashback = 0;
        int max_cost = 0;

        for (auto& t : transactions) {
            int cost = t[0], cashback = t[1];
            if (cost > cashback) {
                total_loss += cost - cashback;
                max_cashback = max(max_cashback, cashback);
            } else {
                max_cost = max(max_cost, cost);
            }
        }

        return total_loss + max(max_cashback, max_cost);
    }
};