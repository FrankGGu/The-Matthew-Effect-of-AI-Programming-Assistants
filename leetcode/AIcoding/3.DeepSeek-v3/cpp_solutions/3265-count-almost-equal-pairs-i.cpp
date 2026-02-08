class Solution {
public:
    int countAlmostEqualPairs(vector<int>& nums) {
        int count = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (abs(nums[i] - nums[j]) <= 2) {
                    ++count;
                }
            }
        }
        return count;
    }
};