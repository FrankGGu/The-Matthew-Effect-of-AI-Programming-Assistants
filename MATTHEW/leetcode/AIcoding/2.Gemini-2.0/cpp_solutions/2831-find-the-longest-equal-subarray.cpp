#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestEqualSubarray(vector<int>& nums, int k) {
        int n = nums.size();
        int maxLen = 0;
        unordered_map<int, int> count;
        int l = 0;
        int changes = 0;

        for (int r = 0; r < n; ++r) {
            count[nums[r]]++;
            int freq = 0;
            for (auto const& [key, val] : count) {
                freq = max(freq, val);
            }

            changes = (r - l + 1) - freq;

            while (changes > k) {
                count[nums[l]]--;

                freq = 0;
                for (auto const& [key, val] : count) {
                    freq = max(freq, val);
                }
                changes = (r - l + 1) - freq;
                l++;
            }
            maxLen = max(maxLen, r - l + 1);
        }

        return maxLen;
    }
};