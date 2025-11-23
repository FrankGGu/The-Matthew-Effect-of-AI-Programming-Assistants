class Solution {
public:
    vector<vector<int>> findSubarrays(vector<int>& nums) {
        vector<vector<int>> result;
        for (int i = 0; i < nums.size() - 1; ++i) {
            if (nums[i] < nums[i + 1]) {
                vector<int> subarray;
                subarray.push_back(nums[i]);
                while (i < nums.size() - 1 && nums[i] < nums[i + 1]) {
                    subarray.push_back(nums[i + 1]);
                    i++;
                }
                result.push_back(subarray);
            }
        }
        return result;
    }
};