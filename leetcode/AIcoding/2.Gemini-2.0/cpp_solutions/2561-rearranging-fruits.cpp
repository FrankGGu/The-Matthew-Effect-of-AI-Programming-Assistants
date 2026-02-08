#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    long long minCost(vector<int>& basket1, vector<int>& basket2) {
        vector<int> diff;
        vector<int> cnt(100001, 0);
        int minVal = 100001;

        for (int x : basket1) {
            cnt[x]++;
            minVal = min(minVal, x);
        }
        for (int x : basket2) {
            cnt[x]--;
            minVal = min(minVal, x);
        }

        for (int i = 1; i <= 100000; i++) {
            if (cnt[i] % 2 != 0) return -1;
            for (int j = 0; j < abs(cnt[i] / 2); j++) {
                if (cnt[i] > 0) {
                    diff.push_back(i);
                }
            }
        }

        long long ans = 0;
        for (int i = 0; i < diff.size(); i++) {
            ans += min((long long)diff[i], 2LL * minVal);
        }

        return ans;
    }
};