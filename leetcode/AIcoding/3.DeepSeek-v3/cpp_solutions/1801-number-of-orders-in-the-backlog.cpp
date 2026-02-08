class Solution {
public:
    int getNumberOfBacklogOrders(vector<vector<int>>& orders) {
        priority_queue<pair<int, int>> buy_pq;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> sell_pq;

        for (auto& order : orders) {
            int price = order[0], amount = order[1], type = order[2];

            if (type == 0) {
                while (amount > 0 && !sell_pq.empty() && sell_pq.top().first <= price) {
                    auto [sell_price, sell_amount] = sell_pq.top();
                    sell_pq.pop();
                    int min_amount = min(amount, sell_amount);
                    amount -= min_amount;
                    sell_amount -= min_amount;
                    if (sell_amount > 0) {
                        sell_pq.push({sell_price, sell_amount});
                    }
                }
                if (amount > 0) {
                    buy_pq.push({price, amount});
                }
            } else {
                while (amount > 0 && !buy_pq.empty() && buy_pq.top().first >= price) {
                    auto [buy_price, buy_amount] = buy_pq.top();
                    buy_pq.pop();
                    int min_amount = min(amount, buy_amount);
                    amount -= min_amount;
                    buy_amount -= min_amount;
                    if (buy_amount > 0) {
                        buy_pq.push({buy_price, buy_amount});
                    }
                }
                if (amount > 0) {
                    sell_pq.push({price, amount});
                }
            }
        }

        long res = 0;
        const int MOD = 1e9 + 7;

        while (!buy_pq.empty()) {
            res += buy_pq.top().second;
            buy_pq.pop();
        }
        while (!sell_pq.empty()) {
            res += sell_pq.top().second;
            sell_pq.pop();
        }

        return res % MOD;
    }
};