#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findShortestSubArray(vector<int>& nums) {
        unordered_map<int, int> count, first, last;
        int degree = 0;
        for (int i = 0; i < nums.size(); i++) {
            int x = nums[i];
            count[x]++;
            if (first.find(x) == first.end()) {
                first[x] = i;
            }
            last[x] = i;
            degree = max(degree, count[x]);
        }

        int ans = nums.size();
        for (auto it : count) {
            if (it.second == degree) {
                ans = min(ans, last[it.first] - first[it.first] + 1);
            }
        }
        return ans;
    }
};