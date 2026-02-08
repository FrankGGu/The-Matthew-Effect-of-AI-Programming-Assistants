class Solution {
public:
    int movesToMakeZigzag(vector<int>& nums) {
        int n = nums.size();
        int moves1 = 0, moves2 = 0;

        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                if (i > 0) moves1 += max(0, nums[i] - nums[i - 1] + 1);
                if (i < n - 1) moves1 += max(0, nums[i] - nums[i + 1] + 1);
            } else {
                if (i > 0) moves2 += max(0, nums[i] - nums[i - 1] + 1);
                if (i < n - 1) moves2 += max(0, nums[i] - nums[i + 1] + 1);
            }
        }

        return min(moves1, moves2);
    }
};