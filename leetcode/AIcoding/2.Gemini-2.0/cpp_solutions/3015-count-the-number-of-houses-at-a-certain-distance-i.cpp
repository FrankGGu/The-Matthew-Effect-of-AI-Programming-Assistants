#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> countOfPairs(int n, int x, int y) {
        vector<int> ans(n, 0);
        for (int i = 1; i <= n; ++i) {
            for (int j = i + 1; j <= n; ++j) {
                int dist = min({abs(i - j), abs(i - x) + abs(y - j) + 1, abs(i - y) + abs(x - j) + 1});
                ans[dist - 1] += 2;
            }
        }
        return ans;
    }
};