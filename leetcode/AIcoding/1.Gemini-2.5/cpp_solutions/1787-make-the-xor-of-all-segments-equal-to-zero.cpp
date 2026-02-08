#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minChanges(vector<int>& nums, int k) {
        int n = nums.size();
        int ans = 0;
        for (int i = 0; i < k; ++i) {
            unordered_map<int, int> cnt;
            int segmentSize = 0;
            for (int j = i; j < n; j += k) {
                cnt[nums[j]]++;
                segmentSize++;
            }
            int maxFreq = 0;
            for (auto const& [key, val] : cnt) {
                maxFreq = max(maxFreq, val);
            }
            ans += (segmentSize - maxFreq);
        }
        return ans;
    }
};