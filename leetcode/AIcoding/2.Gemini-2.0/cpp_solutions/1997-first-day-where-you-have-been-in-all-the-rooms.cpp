#include <vector>

using namespace std;

class Solution {
public:
    int firstDayBeenInAllRooms(vector<int>& nextVisit) {
        int n = nextVisit.size();
        vector<long long> dp(n, 0);
        long long mod = 1e9 + 7;

        for (int i = 1; i < n; ++i) {
            long long prev = dp[i - 1];
            long long next = nextVisit[i - 1];
            long long diff = prev - dp[next] + 1;
            if (diff < 0) {
                diff += mod;
            }
            dp[i] = (prev + 1 + diff) % mod;
        }

        return dp[n - 1];
    }
};