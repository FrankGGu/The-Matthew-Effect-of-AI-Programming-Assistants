#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxOperations(vector<int>& nums) {
        int n = nums.size();
        int ones = accumulate(nums.begin(), nums.end(), 0);
        int ans = 0;
        int l = 0, r = n - 1;
        while (l < r) {
            if (nums[l] == 1) {
                l++;
                continue;
            }
            if (nums[r] == 0) {
                r--;
                continue;
            }
            swap(nums[l], nums[r]);
            ans++;
            l++;
            r--;
        }
        return ans;
    }
};