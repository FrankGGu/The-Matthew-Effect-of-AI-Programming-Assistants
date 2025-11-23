#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSumWithK(vector<int>& nums, int k) {
        sort(nums.rbegin(), nums.rend());
        int sum = 0;
        for (int i = 0; i < min((int)nums.size(), k); ++i) {
            sum += nums[i];
        }
        return sum;
    }
};