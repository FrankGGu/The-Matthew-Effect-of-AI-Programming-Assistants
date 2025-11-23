class Solution {
public:
    int bestArrangement(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int maxPosition = 0;
        for (int i = 0; i < nums.size(); ++i) {
            maxPosition += min(nums[i], i + 1);
        }
        return maxPosition;
    }
};