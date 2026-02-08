#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> getTriggerTime(vector<vector<int>>& increase, vector<vector<int>>& requirements) {
        int n = increase.size();
        int m = requirements.size();
        vector<int> ans(m, -1);

        for (int i = 0; i < m; ++i) {
            int c = requirements[i][0];
            int r = requirements[i][1];
            int h = requirements[i][2];

            int curC = 0, curR = 0, curH = 0;
            if (c <= 0 && r <= 0 && h <= 0) {
                ans[i] = 0;
                continue;
            }

            for (int j = 0; j < n; ++j) {
                curC += increase[j][0];
                curR += increase[j][1];
                curH += increase[j][2];

                if (curC >= c && curR >= r && curH >= h) {
                    ans[i] = j + 1;
                    break;
                }
            }
        }

        return ans;
    }
};