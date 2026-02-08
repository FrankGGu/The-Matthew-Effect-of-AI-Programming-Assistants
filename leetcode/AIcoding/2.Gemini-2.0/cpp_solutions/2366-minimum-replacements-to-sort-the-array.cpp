#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumReplacement(vector<int>& nums) {
        int n = nums.size();
        long long ans = 0;
        int last = nums[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            if (nums[i] > last) {
                int k = (nums[i] + last - 1) / last;
                ans += k - 1;
                last = nums[i] / k;
            } else {
                last = nums[i];
            }
        }
        return ans;
    }
};