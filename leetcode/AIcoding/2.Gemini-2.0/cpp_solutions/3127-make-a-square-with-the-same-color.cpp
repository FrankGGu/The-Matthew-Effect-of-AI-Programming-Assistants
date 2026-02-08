#include <vector>

using namespace std;

class Solution {
public:
    int minimumChanges(vector<string>& grid) {
        int n = grid.size();
        int ans = 0;
        for (int i = 0; i < n / 2; ++i) {
            int cnt0 = 0;
            int cnt1 = 0;
            if (grid[i][i] == '0') cnt0++; else cnt1++;
            if (grid[i][n - 1 - i] == '0') cnt0++; else cnt1++;
            if (grid[n - 1 - i][i] == '0') cnt0++; else cnt1++;
            if (grid[n - 1 - i][n - 1 - i] == '0') cnt0++; else cnt1++;
            ans += min(cnt0, cnt1);
        }
        return ans;
    }
};