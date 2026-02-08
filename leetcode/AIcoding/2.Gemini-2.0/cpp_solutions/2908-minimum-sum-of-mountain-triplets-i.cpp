#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumSum(vector<int>& nums) {
        int n = nums.size();
        int minSum = -1;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                for (int k = j + 1; k < n; ++k) {
                    if (nums[i] < nums[j] && nums[j] > nums[k]) {
                        int currentSum = nums[i] + nums[j] + nums[k];
                        if (minSum == -1 || currentSum < minSum) {
                            minSum = currentSum;
                        }
                    }
                }
            }
        }

        return minSum;
    }
};