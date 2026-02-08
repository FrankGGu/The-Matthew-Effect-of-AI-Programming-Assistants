#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int sumDistance(vector<int>& nums, string s, int d) {
        int n = nums.size();
        vector<long long> pos(n);
        for (int i = 0; i < n; ++i) {
            if (s[i] == 'L') {
                pos[i] = (long long)nums[i] - d;
            } else {
                pos[i] = (long long)nums[i] + d;
            }
        }
        sort(pos.begin(), pos.end());
        long long ans = 0;
        long long mod = 1e9 + 7;
        long long sum = 0;
        for (int i = 0; i < n; ++i) {
            ans = (ans + (pos[i] * i - sum) % mod) % mod;
            sum = (sum + pos[i]) % mod;
        }
        if (ans < 0) ans += mod;
        return (int)ans;
    }
};