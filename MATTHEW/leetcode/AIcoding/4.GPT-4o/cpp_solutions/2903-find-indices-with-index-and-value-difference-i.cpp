class Solution {
public:
    vector<int> findIndices(vector<int>& nums) {
        vector<int> result;
        for (int i = 0; i < nums.size(); ++i) {
            if (abs(i - nums[i]) == 0) {
                result.push_back(i);
            }
        }
        return result;
    }
};