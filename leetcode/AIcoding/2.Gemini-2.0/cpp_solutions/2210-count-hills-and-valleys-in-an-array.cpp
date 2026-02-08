class Solution {
public:
    int countHillValley(vector<int>& nums) {
        int n = nums.size();
        if (n < 3) return 0;

        int count = 0;
        int prev = nums[0];
        for (int i = 1; i < n - 1; ++i) {
            if (nums[i] == prev) continue;

            int next_diff_idx = -1;
            for (int j = i + 1; j < n; ++j) {
                if (nums[j] != nums[i]) {
                    next_diff_idx = j;
                    break;
                }
            }

            if (next_diff_idx == -1) break;

            if ((nums[i] > prev && nums[i] > nums[next_diff_idx]) ||
                (nums[i] < prev && nums[i] < nums[next_diff_idx])) {
                count++;
            }

            prev = nums[i];
            i = next_diff_idx - 1;

        }
        return count;
    }
};