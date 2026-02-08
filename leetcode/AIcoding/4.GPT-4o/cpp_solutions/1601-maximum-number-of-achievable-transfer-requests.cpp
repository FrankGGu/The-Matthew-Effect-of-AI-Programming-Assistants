class Solution {
public:
    int maximumRequests(int n, vector<vector<int>>& requests) {
        int m = requests.size(), maxRequests = 0;
        for (int mask = 0; mask < (1 << m); ++mask) {
            vector<int> balance(n, 0);
            int count = 0;
            for (int i = 0; i < m; ++i) {
                if (mask & (1 << i)) {
                    balance[requests[i][0]]--;
                    balance[requests[i][1]]++;
                    count++;
                }
            }
            if (all_of(balance.begin(), balance.end(), [](int b) { return b == 0; })) {
                maxRequests = max(maxRequests, count);
            }
        }
        return maxRequests;
    }
};