class Solution {
public:
    int minimumDeletions(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int deletions = 0;
        for (int i = 0; i < nums.size() - 1; i++) {
            if (nums[i] == nums[i + 1]) {
                deletions++;
            }
        }
        return deletions;
    }
};