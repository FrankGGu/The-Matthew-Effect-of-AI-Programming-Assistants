class Solution {
public:
    int countMaxOrSubsets(vector<int>& nums) {
        int maxOr = 0, count = 0;
        int n = nums.size();

        for (int i = 0; i < (1 << n); ++i) {
            int currentOr = 0;
            for (int j = 0; j < n; ++j) {
                if (i & (1 << j)) {
                    currentOr |= nums[j];
                }
            }
            if (currentOr > maxOr) {
                maxOr = currentOr;
                count = 1;
            } else if (currentOr == maxOr) {
                count++;
            }
        }

        return count;
    }
};