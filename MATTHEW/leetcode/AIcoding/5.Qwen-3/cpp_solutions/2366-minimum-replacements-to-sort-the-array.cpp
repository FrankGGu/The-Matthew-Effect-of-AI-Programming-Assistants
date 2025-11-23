#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumReplacement(vector<int>& nums) {
        int n = nums.size();
        int res = 0;
        for (int i = n - 2; i >= 0; --i) {
            if (nums[i] <= nums[i + 1]) continue;
            int k = nums[i] / nums[i + 1];
            if (nums[i] % nums[i + 1] != 0) ++k;
            res += k - 1;
            nums[i] = nums[i] / k;
        }
        return res;
    }
};