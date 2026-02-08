#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestConsecutive(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;

        sort(nums.begin(), nums.end());
        nums.erase(unique(nums.begin(), nums.end()), nums.end());
        n = nums.size();

        int maxLen = 1;
        for (int i = 0; i < n; ++i) {
            int len = 1;
            for (int j = i + 1; j < n; ++j) {
                if (nums[j] == nums[j - 1] + 1) {
                    len++;
                } else {
                    break;
                }
            }
            maxLen = max(maxLen, len);
        }

        return maxLen;
    }

    int maxConsecutiveElements(vector<int>& nums) {
        int n = nums.size();
        int ans = 0;
        for (int i = 0; i < n; ++i) {
            vector<int> temp = nums;
            temp[i]++;
            ans = max(ans, longestConsecutive(temp));
        }
        return ans;
    }
};