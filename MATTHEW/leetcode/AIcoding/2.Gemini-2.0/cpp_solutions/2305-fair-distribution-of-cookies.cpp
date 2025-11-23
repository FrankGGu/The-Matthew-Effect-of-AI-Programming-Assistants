#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int distributeCookies(vector<int>& cookies, int k) {
        int n = cookies.size();
        vector<int> distribution(k, 0);
        int ans = INT_MAX;

        function<void(int)> solve = [&](int i) {
            if (i == n) {
                int maxVal = 0;
                for (int j = 0; j < k; ++j) {
                    maxVal = max(maxVal, distribution[j]);
                }
                ans = min(ans, maxVal);
                return;
            }

            for (int j = 0; j < k; ++j) {
                distribution[j] += cookies[i];
                solve(i + 1);
                distribution[j] -= cookies[i];
            }
        };

        solve(0);
        return ans;
    }
};