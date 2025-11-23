#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int getNumberOfBacklogOrders(vector<vector<int>>& orders) {
        priority_queue<pair<int, int>> buyOrders;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> sellOrders;

        for (auto& order : orders) {
            int price = order[0];
            int amount = order[1];
            int type = order[2];

            if (type == 0) { 
                while (amount > 0 && !sellOrders.empty() && sellOrders.top().first <= price) {
                    pair<int, int> sellOrder = sellOrders.top();
                    sellOrders.pop();

                    int sellAmount = sellOrder.second;
                    int matchAmount = min(amount, sellAmount);

                    amount -= matchAmount;
                    sellAmount -= matchAmount;

                    if (sellAmount > 0) {
                        sellOrders.push({sellOrder.first, sellAmount});
                    }
                }

                if (amount > 0) {
                    buyOrders.push({price, amount});
                }
            } else { 
                while (amount > 0 && !buyOrders.empty() && buyOrders.top().first >= price) {
                    pair<int, int> buyOrder = buyOrders.top();
                    buyOrders.pop();

                    int buyAmount = buyOrder.second;
                    int matchAmount = min(amount, buyAmount);

                    amount -= matchAmount;
                    buyAmount -= matchAmount;

                    if (buyAmount > 0) {
                        buyOrders.push({buyOrder.first, buyAmount});
                    }
                }

                if (amount > 0) {
                    sellOrders.push({price, amount});
                }
            }
        }

        long long totalOrders = 0;
        long long mod = 1e9 + 7;

        while (!buyOrders.empty()) {
            totalOrders = (totalOrders + buyOrders.top().second) % mod;
            buyOrders.pop();
        }

        while (!sellOrders.empty()) {
            totalOrders = (totalOrders + sellOrders.top().second) % mod;
            sellOrders.pop();
        }

        return (int)totalOrders;
    }
};