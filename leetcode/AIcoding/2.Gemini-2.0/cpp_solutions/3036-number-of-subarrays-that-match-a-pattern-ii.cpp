#include <vector>

using namespace std;

class Solution {
public:
    int countMatchingSubarrays(vector<int>& nums, vector<int>& pattern) {
        int n = nums.size();
        int m = pattern.size();
        vector<int> diff(n - 1);
        for (int i = 0; i < n - 1; ++i) {
            diff[i] = (nums[i + 1] > nums[i]) ? 1 : ((nums[i + 1] < nums[i]) ? -1 : 0);
        }

        int count = 0;
        for (int i = 0; i <= n - m - 1; ++i) {
            bool match = true;
            for (int j = 0; j < m; ++j) {
                if (diff[i + j] != pattern[j]) {
                    match = false;
                    break;
                }
            }
            if (match) {
                count++;
            }
        }

        return count;
    }
};