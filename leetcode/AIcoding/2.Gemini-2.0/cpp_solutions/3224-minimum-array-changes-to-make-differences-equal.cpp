#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minChanges(vector<int>& nums, int k) {
        int n = nums.size();
        int ans = 0;
        for (int i = 0; i < k; ++i) {
            unordered_map<int, int> counts;
            int total = 0;
            for (int j = i; j < n; j += k) {
                counts[nums[j]]++;
                total++;
            }
            int maxCount = 0;
            for (auto const& [key, val] : counts) {
                maxCount = max(maxCount, val);
            }
            ans += (total - maxCount);
        }
        return ans;
    }
};