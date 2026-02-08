#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int missingInteger(vector<int>& nums) {
        int sum = nums[0];
        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] == nums[i - 1] + 1) {
                sum += nums[i];
            } else {
                break;
            }
        }

        unordered_set<int> numSet(nums.begin(), nums.end());
        int missing = sum;
        while (numSet.count(missing)) {
            missing++;
        }
        return missing;
    }
};