class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        int n = nums.size();
        int ones = count(nums.begin(), nums.end(), 1);
        if (ones == n) return 0;

        int minOps = n;
        for (int i = 0; i < n; ++i) {
            if (nums[i] == 0) {
                int ops = 0;
                for (int j = 0; j < n; ++j) {
                    if (nums[j] == 0) {
                        ops++;
                    }
                }
                minOps = min(minOps, ops);
            }
        }
        return minOps + (ones > 0 ? 1 : 0);
    }
};