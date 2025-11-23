#include <vector>

using namespace std;

class Solution {
public:
    int match(vector<int>& nums, vector<int>& pattern) {
        int n = nums.size();
        int m = pattern.size();
        int count = 0;

        for (int i = 0; i <= n - m - 1; ++i) {
            bool match_found = true;
            for (int j = 0; j < m; ++j) {
                if (pattern[j] == 1 && nums[i + j + 1] <= nums[i + j]) {
                    match_found = false;
                    break;
                } else if (pattern[j] == 0 && nums[i + j + 1] != nums[i + j]) {
                    match_found = false;
                    break;
                } else if (pattern[j] == -1 && nums[i + j + 1] >= nums[i + j]) {
                    match_found = false;
                    break;
                }
            }
            if (match_found) {
                count++;
            }
        }

        return count;
    }
};