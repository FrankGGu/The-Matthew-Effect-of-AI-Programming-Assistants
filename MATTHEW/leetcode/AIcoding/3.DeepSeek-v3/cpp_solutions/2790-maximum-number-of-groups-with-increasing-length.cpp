#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxIncreasingGroups(vector<int>& usageLimits) {
        sort(usageLimits.begin(), usageLimits.end());
        long long total = 0;
        int res = 0;
        for (int num : usageLimits) {
            total += num;
            if (total >= (res + 1LL) * (res + 2) / 2) {
                res++;
            }
        }
        return res;
    }
};