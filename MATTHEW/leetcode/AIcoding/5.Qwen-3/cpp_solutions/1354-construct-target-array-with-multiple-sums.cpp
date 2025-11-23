#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool isPossible(vector<int>& nums) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        unordered_set<int> seen;
        return dfs(nums, sum, 0, seen);
    }

    bool dfs(vector<int>& nums, int target, int index, unordered_set<int>& seen) {
        if (index == nums.size()) {
            return target == 0;
        }
        if (seen.find(target) != seen.end()) {
            return false;
        }
        seen.insert(target);
        return dfs(nums, target - nums[index], index + 1, seen) || dfs(nums, target, index + 1, seen);
    }
};