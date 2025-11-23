#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberofBacklogOrders(vector<vector<int>>& orders) {
        priority_queue<pair<int, int>> buy;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> sell;

        for (auto& order : orders) {
            int price = order[0];
            int amount = order[1];
            int type = order[2];

            if (type == 0) {
                while (amount > 0 && !sell.empty() && sell.top().first <= price) {
                    int sell_price = sell.top().first;
                    int sell_amount = sell.top().second;
                    sell.pop();
                    if (sell_amount > amount) {
                        sell.push({sell_price, sell_amount - amount});
                        amount = 0;
                    } else {
                        amount -= sell_amount;
                    }
                }
                if (amount > 0) {
                    buy.push({price, amount});
                }
            } else {
                while (amount > 0 && !buy.empty() && buy.top().first >= price) {
                    int buy_price = buy.top().first;
                    int buy_amount = buy.top().second;
                    buy.pop();
                    if (buy_amount > amount) {
                        buy.push({buy_price, buy_amount - amount});
                        amount = 0;
                    } else {
                        amount -= buy_amount;
                    }
                }
                if (amount > 0) {
                    sell.push({price, amount});
                }
            }
        }

        int total = 0;
        int mod = 1e9 + 7;

        while (!buy.empty()) {
            total = (total + buy.top().second) % mod;
            buy.pop();
        }

        while (!sell.empty()) {
            total = (total + sell.top().second) % mod;
            sell.pop();
        }

        return total;
    }
};