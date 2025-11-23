#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> checkoutOptions(int n, int m, vector<int>& prices) {
        vector<int> result;
        priority_queue<int, vector<int>, greater<int>> pq;
        for (int i = 0; i < n; ++i) {
            pq.push(prices[i]);
        }
        for (int i = 0; i < m; ++i) {
            if (!pq.empty()) {
                result.push_back(pq.top());
                pq.pop();
            }
        }
        return result;
    }
};