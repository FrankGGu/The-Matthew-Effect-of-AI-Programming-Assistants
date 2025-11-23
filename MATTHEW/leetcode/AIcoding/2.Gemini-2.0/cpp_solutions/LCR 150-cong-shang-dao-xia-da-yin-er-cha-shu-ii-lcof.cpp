#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int record(vector<vector<int>>& lamps, vector<vector<int>>& query) {
        int n = lamps.size();
        int m = query.size();
        int ans = 0;

        for (int i = 0; i < m; ++i) {
            int x = query[i][0];
            int y = query[i][1];
            bool illuminated = false;
            for (int j = 0; j < n; ++j) {
                if (lamps[j][0] <= x && x <= lamps[j][2] && lamps[j][1] <= y && y <= lamps[j][3]) {
                    illuminated = true;
                    break;
                }
            }

            if (illuminated) {
                ans++;
            }
        }

        return ans;
    }
};