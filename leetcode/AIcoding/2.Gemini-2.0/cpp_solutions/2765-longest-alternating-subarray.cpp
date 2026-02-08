#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestAlternatingSubarray(vector<int>& nums, int threshold) {
        int maxLen = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            if (nums[i] > threshold) continue;
            if (nums[i] % 2 != 0) continue; 

            int currentLen = 1;
            maxLen = max(maxLen, currentLen);

            for (int j = i + 1; j < n; ++j) {
                if (nums[j] > threshold) break;
                if (nums[j] % 2 == nums[j-1] % 2) break;
                currentLen++;
                maxLen = max(maxLen, currentLen);
            }
        }
        return maxLen;
    }
};