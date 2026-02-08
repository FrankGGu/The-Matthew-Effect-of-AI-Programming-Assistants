#include <iostream>
#include <vector>
#include <deque>
#include <algorithm>

using namespace std;

class Solution {
public:
    int boxDelivering(vector<int>& boxes) {
        int n = boxes.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + boxes[i];
        }

        deque<int> dq;
        vector<long long> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            while (!dq.empty() && prefix[i] - prefix[dq.back()] > 1000) {
                dq.pop_back();
            }

            if (dq.empty()) {
                dp[i] = dp[0] + (prefix[i] - prefix[0]) + 10;
            } else {
                dp[i] = dp[dq.back()] + (prefix[i] - prefix[dq.back()]) + 10;
            }

            while (!dq.empty() && dp[i] <= dp[dq.back()]) {
                dq.pop_back();
            }

            dq.push_back(i);
        }

        return dp[n];
    }
};