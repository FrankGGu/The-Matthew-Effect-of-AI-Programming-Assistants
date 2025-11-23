#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    bool containsNearbyAlmostDuplicate(int nums, int k, int t, vector<int>& nums_vec) {
        map<long long, int> m;
        for (int i = 0; i < nums; ++i) {
            long long x = nums_vec[i];
            long long y = x;
            if (y < 0) y = -y;
            if (y > t) {
                y = x / t;
                if (y * t <= x && y * t + t >= x) continue;
                else if (y - 1 >= 0 && (y - 1) * t <= x && (y - 1) * t + t >= x) continue;
                else if (y + 1 <= t && (y + 1) * t <= x && (y + 1) * t + t >= x) continue;
            }
            for (auto& p : m) {
                if (abs(x - p.first) <= t && abs(i - p.second) <= k) return true;
            }
            m[x] = i;
            if (m.size() > k) m.erase(nums_vec[i - k]);
        }
        return false;
    }
};