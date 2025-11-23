class Solution {
public:
    vector<int> alternatingGroups(vector<int>& nums) {
        vector<int> result;
        int n = nums.size();
        for (int i = 0; i < n; i++) {
            if ((i % 2 == 0 && nums[i] > 0) || (i % 2 == 1 && nums[i] < 0)) {
                result.push_back(nums[i]);
            }
        }
        return result;
    }
};