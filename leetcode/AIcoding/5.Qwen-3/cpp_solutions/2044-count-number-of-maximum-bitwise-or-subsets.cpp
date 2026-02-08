#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countMaxOrSubsets(vector<int>& nums) {
        int maxOr = 0;
        for (int num : nums) {
            maxOr |= num;
        }

        int count = 0;
        vector<int> subsets;
        function<void(int, int)> backtrack = [&](int index, int currentOr) {
            if (index == nums.size()) {
                if (currentOr == maxOr) {
                    count++;
                }
                return;
            }
            backtrack(index + 1, currentOr);
            backtrack(index + 1, currentOr | nums[index]);
        };

        backtrack(0, 0);
        return count;
    }
};