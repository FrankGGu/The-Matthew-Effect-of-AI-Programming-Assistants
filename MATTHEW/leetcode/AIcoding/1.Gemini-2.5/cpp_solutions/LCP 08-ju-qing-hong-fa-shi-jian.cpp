#include <iostream>
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

            int cur_c = 0;
            int cur_r = 0;
            int cur_h = 0;

            for (int j = 0; j <= n; ++j) {
                if (cur_c >= c && cur_r >= r && cur_h >= h) {
                    ans[i] = j;
                    break;
                }

                if (j < n) {
                    cur_c += increase[j][0];
                    cur_r += increase[j][1];
                    cur_h += increase[j][2];
                }
            }
        }

        return ans;
    }
};