class Solution {
public:
    int maxFrequencyAfterOperation(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;

        vector<int> left(n, 1);
        vector<int> right(n, 1);

        for (int i = 1; i < n; ++i) {
            if (nums[i] == nums[i-1]) {
                left[i] = left[i-1] + 1;
            } else {
                left[i] = 1;
            }
        }

        for (int i = n-2; i >= 0; --i) {
            if (nums[i] == nums[i+1]) {
                right[i] = right[i+1] + 1;
            } else {
                right[i] = 1;
            }
        }

        int max_freq = 1;
        for (int i = 0; i < n; ++i) {
            int current = 1;
            if (i > 0 && i < n-1 && nums[i-1] == nums[i+1]) {
                current = left[i-1] + right[i+1] + 1;
            } else {
                if (i > 0) current = max(current, left[i-1] + 1);
                if (i < n-1) current = max(current, right[i+1] + 1);
            }
            max_freq = max(max_freq, current);
        }

        return max_freq;
    }
};