class Solution {
public:
    int minimumChanges(vector<int>& nums) {
        int n = nums.size();
        int ans = INT_MAX;

        for (int d = -100; d <= 100; ++d) {
            int changes = 0;
            for (int i = 0; i < n; ++i) {
                if ((nums[i] + d) % 2 != 0) {
                    changes++;
                }
            }
            ans = min(ans, changes);
        }

        return ans;
    }
};