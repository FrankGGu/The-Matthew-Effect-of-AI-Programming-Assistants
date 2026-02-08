#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int beautifulSubsets(vector<int>& nums, int k) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        int result = 0;

        function<void(int, int)> backtrack = [&](int index, int currentCount) {
            if (index == nums.size()) {
                if (currentCount > 0) {
                    result++;
                }
                return;
            }

            int num = nums[index];
            bool canTake = true;
            if (count.find(num - k) != count.end() && count[num - k] > 0) {
                canTake = false;
            }
            if (canTake) {
                count[num]--;
                backtrack(index + 1, currentCount + 1);
                count[num]++;
            }

            backtrack(index + 1, currentCount);
        };

        backtrack(0, 0);
        return result;
    }
};