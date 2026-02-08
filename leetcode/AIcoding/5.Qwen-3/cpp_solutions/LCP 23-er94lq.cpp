#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool checkPermutation(vector<int>& nums) {
        int n = nums.size();
        unordered_set<int> seen;
        for (int i = 0; i < n; ++i) {
            if (nums[i] < 1 || nums[i] > n) return false;
            if (seen.find(nums[i]) != seen.end()) return false;
            seen.insert(nums[i]);
        }
        return true;
    }
};