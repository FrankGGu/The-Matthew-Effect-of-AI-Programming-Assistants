#include <vector>

using namespace std;

class Solution {
public:
    vector<int> goodIndices(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> inc(n, 1), dec(n, 1);
        for (int i = 1; i < n; i++) {
            if (nums[i] <= nums[i - 1]) {
                dec[i] = dec[i - 1] + 1;
            }
            if (nums[n - i - 1] <= nums[n - i]) {
                inc[n - i - 1] = inc[n - i] + 1;
            }
        }
        vector<int> ans;
        for (int i = k; i < n - k; i++) {
            if (dec[i - 1] >= k && inc[i + 1] >= k) {
                ans.push_back(i);
            }
        }
        return ans;
    }
};