class Solution {
public:
    int beautifulSubsets(vector<int>& nums, int k) {
        int count = 0;
        int n = nums.size();
        int totalSubsets = 1 << n;

        for (int i = 1; i < totalSubsets; ++i) {
            vector<int> subset;
            for (int j = 0; j < n; ++j) {
                if (i & (1 << j)) {
                    subset.push_back(nums[j]);
                }
            }
            bool isBeautiful = true;
            for (int m = 0; m < subset.size(); ++m) {
                for (int n = m + 1; n < subset.size(); ++n) {
                    if (abs(subset[m] - subset[n]) == k) {
                        isBeautiful = false;
                        break;
                    }
                }
                if (!isBeautiful) break;
            }
            if (isBeautiful) count++;
        }
        return count;
    }
};