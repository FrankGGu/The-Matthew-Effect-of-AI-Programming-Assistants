#include <iostream>
#include <vector>
#include <queue>
#include <utility>
#include <algorithm>

using namespace std;

class Solution {
public:
    int getNumberOfBacklogOrders(vector<vector<int>>& orders) {
        priority_queue<pair<int, int>> buy_backlog;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> sell_backlog;

        long long MOD = 1e9 + 7;

        for (const auto& order : orders) {
            int price = order[0];
            int amount = order[1];
            int orderType = order[2];

            if (orderType == 0) { // Buy order
                while (amount > 0 && !sell_backlog.empty() && sell_backlog.top().first <= price) {
                    auto sell_top = sell_backlog.top();
                    sell_backlog.pop();

                    int trade_amount = min(amount, sell_top.second);
                    amount -= trade_amount;
                    sell_top.second -= trade_amount;

                    if (sell_top.second > 0) {
                        sell_backlog.push(sell_top);
                    }
                }
                if (amount > 0) {
                    buy_backlog.push({price, amount});
                }
            } else { // Sell order
                while (amount > 0 && !buy_backlog.empty() && buy_backlog.top().first >= price) {
                    auto buy_top = buy_backlog.top();
                    buy_backlog.pop();

                    int trade_amount = min(amount, buy_top.second);
                    amount -= trade_amount;
                    buy_top.second -= trade_amount;

                    if (buy_top.second > 0) {
                        buy_backlog.push(buy_top);
                    }
                }
                if (amount > 0) {
                    sell_backlog.push({price, amount});
                }
            }
        }

        long long total_orders = 0;
        while (!buy_backlog.empty()) {
            total_orders = (total_orders + buy_backlog.top().second) % MOD;
            buy_backlog.pop();
        }
        while (!sell_backlog.empty()) {
            total_orders = (total_orders + sell_backlog.top().second) % MOD;
            sell_backlog.pop();
        }

        return total_orders;
    }
};