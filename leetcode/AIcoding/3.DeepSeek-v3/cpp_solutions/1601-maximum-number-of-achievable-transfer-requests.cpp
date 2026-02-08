class Solution {
public:
    int maximumRequests(int n, vector<vector<int>>& requests) {
        int m = requests.size();
        int maxRequests = 0;

        for (int mask = 0; mask < (1 << m); ++mask) {
            vector<int> balance(n, 0);
            int currentRequests = 0;

            for (int i = 0; i < m; ++i) {
                if (mask & (1 << i)) {
                    int from = requests[i][0];
                    int to = requests[i][1];
                    balance[from]--;
                    balance[to]++;
                    currentRequests++;
                }
            }

            bool valid = true;
            for (int i = 0; i < n; ++i) {
                if (balance[i] != 0) {
                    valid = false;
                    break;
                }
            }

            if (valid) {
                maxRequests = max(maxRequests, currentRequests);
            }
        }

        return maxRequests;
    }
};