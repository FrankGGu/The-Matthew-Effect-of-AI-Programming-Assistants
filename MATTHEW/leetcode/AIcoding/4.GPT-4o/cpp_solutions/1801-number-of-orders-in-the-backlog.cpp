#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int getNumberOfBacklogOrders(vector<vector<int>>& orders) {
        priority_queue<vector<int>, vector<vector<int>>, greater<vector<int>>> buy, sell;
        const int MOD = 1e9 + 7;

        for (const auto& order : orders) {
            int price = order[0], amount = order[1], type = order[2];
            if (type == 0) {
                while (amount > 0 && !sell.empty() && sell.top()[0] <= price) {
                    int sellAmount = sell.top()[1];
                    if (sellAmount <= amount) {
                        amount -= sellAmount;
                        sell.pop();
                    } else {
                        sell.top()[1] -= amount;
                        amount = 0;
                    }
                }
                if (amount > 0) {
                    buy.push({price, amount});
                }
            } else {
                while (amount > 0 && !buy.empty() && buy.top()[0] >= price) {
                    int buyAmount = buy.top()[1];
                    if (buyAmount <= amount) {
                        amount -= buyAmount;
                        buy.pop();
                    } else {
                        buy.top()[1] -= amount;
                        amount = 0;
                    }
                }
                if (amount > 0) {
                    sell.push({price, amount});
                }
            }
        }

        long long total = 0;
        while (!buy.empty()) {
            total = (total + buy.top()[1]) % MOD;
            buy.pop();
        }
        while (!sell.empty()) {
            total = (total + sell.top()[1]) % MOD;
            sell.pop();
        }

        return total;
    }
};