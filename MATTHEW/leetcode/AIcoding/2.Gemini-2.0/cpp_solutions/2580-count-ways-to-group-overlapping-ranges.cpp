#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countWays(vector<vector<int>>& ranges) {
        sort(ranges.begin(), ranges.end());
        long long mod = 1e9 + 7;
        int count = 1;
        int end = ranges[0][1];
        for (int i = 1; i < ranges.size(); ++i) {
            if (ranges[i][0] > end) {
                count++;
            }
            end = max(end, ranges[i][1]);
        }
        long long ans = 1;
        for (int i = 0; i < count; ++i) {
            ans = (ans * 2) % mod;
        }
        return (int)ans;
    }
};