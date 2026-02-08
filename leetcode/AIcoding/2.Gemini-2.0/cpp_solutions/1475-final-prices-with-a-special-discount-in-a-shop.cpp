#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<int> finalPrices(vector<int>& prices) {
        int n = prices.size();
        vector<int> result(n);
        stack<int> s;

        for (int i = 0; i < n; ++i) {
            while (!s.empty() && prices[s.top()] >= prices[i]) {
                result[s.top()] = prices[s.top()] - prices[i];
                s.pop();
            }
            s.push(i);
        }

        while (!s.empty()) {
            result[s.top()] = prices[s.top()];
            s.pop();
        }

        return result;
    }
};