#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxActiveSections(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;

        vector<int> left(n, 1);
        for (int i = 1; i < n; ++i) {
            if (nums[i] > nums[i-1]) {
                left[i] = left[i-1] + 1;
            }
        }

        vector<int> right(n, 1);
        for (int i = n-2; i >= 0; --i) {
            if (nums[i] < nums[i+1]) {
                right[i] = right[i+1] + 1;
            }
        }

        int max_len = 1;
        for (int i = 0; i < n; ++i) {
            if (i > 0 && i < n-1 && nums[i-1] < nums[i+1]) {
                max_len = max(max_len, left[i-1] + right[i+1]);
            }
            max_len = max(max_len, left[i]);
            max_len = max(max_len, right[i]);
        }

        return max_len;
    }
};