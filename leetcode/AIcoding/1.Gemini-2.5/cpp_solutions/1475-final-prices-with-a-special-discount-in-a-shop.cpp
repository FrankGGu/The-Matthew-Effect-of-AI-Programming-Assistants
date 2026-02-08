#include <vector>
#include <stack>

class Solution {
public:
    std::vector<int> finalPrices(std::vector<int>& prices) {
        std::stack<int> s;
        std::vector<int> result = prices;
        for (int i = 0; i < prices.size(); ++i) {
            while (!s.empty() && prices[s.top()] >= prices[i]) {
                result[s.top()] = prices[s.top()] - prices[i];
                s.pop();
            }
            s.push(i);
        }
        return result;
    }
};