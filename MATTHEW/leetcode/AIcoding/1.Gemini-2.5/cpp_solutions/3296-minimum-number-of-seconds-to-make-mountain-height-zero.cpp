#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumSeconds(vector<int>& nums) {
        int n = nums.size();
        vector<vector<int>> pos(n + 1);
        for (int i = 0; i < n; ++i) {
            pos[nums[i]].push_back(i);
        }

        int ans = n;
        for (int i = 1; i <= n / 2 + 1; ++i) {
            if (pos[i].empty()) continue;
            int mx = 0;
            for (int j = 0; j < pos[i].size(); ++j) {
                int dist;
                if (j == pos[i].size() - 1) {
                    dist = pos[i][0] + n - pos[i][j];
                } else {
                    dist = pos[i][j + 1] - pos[i][j];
                }
                mx = max(mx, dist);
            }
            ans = min(ans, mx);
        }
        return ans;
    }
};