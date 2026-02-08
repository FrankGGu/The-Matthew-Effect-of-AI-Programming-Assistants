#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int sumOfVariableLengthSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        int ans = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                if (j - i + 1 >= k) {
                    int sum = 0;
                    for (int l = i; l <= j; ++l) {
                        sum += nums[l];
                    }
                    ans += sum;
                }
            }
        }
        return ans;
    }
};