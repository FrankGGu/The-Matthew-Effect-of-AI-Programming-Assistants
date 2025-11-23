#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumTimeToBreakLocks(vector<int>& locks, int key) {
        sort(locks.begin(), locks.end());
        int ans = 0;
        for (int lock : locks) {
            ans += min(abs(lock - key), 360 - abs(lock - key));
        }
        return ans;
    }
};