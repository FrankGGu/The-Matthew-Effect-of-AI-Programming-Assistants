#include <vector>

using namespace std;

class Solution {
public:
    vector<int> applyOperations(vector<int>& nums) {
        int n = nums.size();
        for (int i = 0; i < n - 1; ++i) {
            if (nums[i] == nums[i + 1]) {
                nums[i] *= 2;
                nums[i + 1] = 0;
            }
        }

        vector<int> result;
        int zeroCount = 0;
        for (int num : nums) {
            if (num != 0) {
                result.push_back(num);
            } else {
                zeroCount++;
            }
        }

        for (int i = 0; i < zeroCount; ++i) {
            result.push_back(0);
        }

        return result;
    }
};