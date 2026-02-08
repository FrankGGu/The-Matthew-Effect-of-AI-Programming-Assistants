#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int beautifulSubsets(vector<int>& nums, int k) {
        int n = nums.size();
        int count = 0;

        function<void(int, vector<int>)> solve = 
            [&](int index, vector<int> subset) {
            if (index == n) {
                if (subset.empty()) return;
                count++;
                return;
            }

            solve(index + 1, subset);

            bool valid = true;
            for (int num : subset) {
                if (abs(nums[index] - num) == k) {
                    valid = false;
                    break;
                }
            }

            if (valid) {
                subset.push_back(nums[index]);
                solve(index + 1, subset);
            }
        };

        solve(0, {});
        return count;
    }
};