#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int minJump(vector<int>& jump) {
        int n = jump.size();
        vector<int> dp(n, INT_MAX);
        dp[0] = 0;
        queue<int> q;
        q.push(0);
        int max_reached = 0;

        while (!q.empty()) {
            int pos = q.front();
            q.pop();

            int next = pos + jump[pos];
            if (next >= n) {
                return dp[pos] + 1;
            } else if (dp[next] > dp[pos] + 1) {
                dp[next] = dp[pos] + 1;
                q.push(next);
            }

            for (int i = max_reached + 1; i < pos; ++i) {
                if (dp[i] > dp[pos] + 1) {
                    dp[i] = dp[pos] + 1;
                    q.push(i);
                }
            }
            max_reached = max(max_reached, pos);
        }

        return -1;
    }
};