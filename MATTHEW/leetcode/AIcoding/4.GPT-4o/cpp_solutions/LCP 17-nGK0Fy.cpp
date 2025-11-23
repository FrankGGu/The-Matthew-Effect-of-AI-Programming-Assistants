class Solution {
public:
    bool checkArithmeticTriplets(vector<int>& nums, int diff) {
        unordered_set<int> numSet(nums.begin(), nums.end());
        for (int num : nums) {
            if (numSet.count(num + diff) && numSet.count(num + 2 * diff)) {
                return true;
            }
        }
        return false;
    }
};