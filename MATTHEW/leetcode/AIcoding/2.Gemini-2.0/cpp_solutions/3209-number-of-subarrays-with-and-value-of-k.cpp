class Solution {
public:
    int countSubarrays(vector<int>& nums, int k) {
        int count = 0;
        for (int i = 0; i < nums.size(); ++i) {
            int currentAnd = nums[i];
            if (currentAnd == k) {
                count++;
            }
            for (int j = i + 1; j < nums.size(); ++j) {
                currentAnd &= nums[j];
                if (currentAnd == k) {
                    count++;
                }
            }
        }
        return count;
    }
};