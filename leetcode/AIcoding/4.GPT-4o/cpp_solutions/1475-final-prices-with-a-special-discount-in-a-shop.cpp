class Solution {
public:
    vector<int> finalPrices(vector<int>& prices) {
        int n = prices.size();
        vector<int> result(prices);
        stack<int> s;

        for (int i = 0; i < n; ++i) {
            while (!s.empty() && prices[s.top()] >= prices[i]) {
                result[s.top()] -= prices[i];
                s.pop();
            }
            s.push(i);
        }

        return result;
    }
};