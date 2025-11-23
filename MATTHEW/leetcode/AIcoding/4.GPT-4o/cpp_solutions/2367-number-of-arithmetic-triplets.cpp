class Solution {
public:
    int countTriplets(vector<int>& nums) {
        int count = 0;
        unordered_set<int> numSet(nums.begin(), nums.end());
        for (int i = 0; i < nums.size(); ++i) {
            for (int j = i + 1; j < nums.size(); ++j) {
                int diff = nums[j] - nums[i];
                if (numSet.count(nums[j] + diff)) {
                    count++;
                }
            }
        }
        return count;
    }
};