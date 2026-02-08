class Solution {
public:
    int maxDifference(vector<int>& nums) {
        int n = nums.size();
        int max_diff = -1;
        for (int i = 0; i < n; ++i) {
            int next = (i + 1) % n;
            if (nums[next] > nums[i]) {
                max_diff = max(max_diff, nums[next] - nums[i]);
            }
        }
        return max_diff;
    }
};