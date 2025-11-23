class Solution {
public:
    int countMatchingSubarrays(vector<int>& nums, vector<int>& pattern) {
        int n = nums.size();
        int m = pattern.size();
        int res = 0;

        for (int i = 0; i <= n - m - 1; ++i) {
            bool match = true;
            for (int k = 0; k < m; ++k) {
                int j = i + k;
                int diff = nums[j + 1] - nums[j];
                int expected = pattern[k];
                if ((expected == 1 && diff <= 0) || 
                    (expected == 0 && diff != 0) || 
                    (expected == -1 && diff >= 0)) {
                    match = false;
                    break;
                }
            }
            if (match) {
                res++;
            }
        }

        return res;
    }
};