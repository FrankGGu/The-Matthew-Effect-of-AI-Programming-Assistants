#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestEqualSubarray(vector<int>& nums, int k) {
        unordered_map<int, vector<int>> indices;
        for (int i = 0; i < nums.size(); ++i) {
            indices[nums[i]].push_back(i);
        }

        int max_len = 0;
        for (auto& [num, pos] : indices) {
            int left = 0;
            for (int right = 0; right < pos.size(); ++right) {
                while ((pos[right] - pos[left] + 1) - (right - left + 1) > k) {
                    left++;
                }
                max_len = max(max_len, right - left + 1);
            }
        }
        return max_len;
    }
};