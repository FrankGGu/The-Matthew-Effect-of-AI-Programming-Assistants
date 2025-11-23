#include <iostream>
#include <vector>
#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    int maximumScore(string s, vector<int>& cost) {
        int n = s.length();
        vector<int> dp(n, 0);
        stack<int> st;

        for (int i = 0; i < n; ++i) {
            while (!st.empty() && s[st.top()] == s[i]) {
                st.pop();
            }
            if (!st.empty()) {
                dp[i] = dp[st.top()] + cost[i];
            }
            st.push(i);
        }

        return *max_element(dp.begin(), dp.end());
    }
};