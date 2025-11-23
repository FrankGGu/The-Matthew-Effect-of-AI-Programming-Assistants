#include <vector>

using namespace std;

class Solution {
public:
    int countMaxOrSubsets(vector<int>& nums) {
        int maxOr = 0;
        for (int num : nums) {
            maxOr |= num;
        }

        int count = 0;
        function<void(int, int)> solve = [&](int index, int currentOr) {
            if (index == nums.size()) {
                if (currentOr == maxOr) {
                    count++;
                }
                return;
            }

            solve(index + 1, currentOr | nums[index]);
            solve(index + 1, currentOr);
        };

        solve(0, 0);
        return count;
    }
};