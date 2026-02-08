class Solution {
public:
    int minSizeSubarray(vector<int>& nums, int target) {
        long long total = accumulate(nums.begin(), nums.end(), 0LL);
        int n = nums.size();
        int k = target / total;
        int rem = target % total;
        if (rem == 0) {
            return k * n;
        }

        vector<int> extended = nums;
        extended.insert(extended.end(), nums.begin(), nums.end());

        int left = 0;
        int current_sum = 0;
        int min_len = INT_MAX;

        for (int right = 0; right < extended.size(); ++right) {
            current_sum += extended[right];
            while (current_sum > rem) {
                current_sum -= extended[left];
                left++;
            }
            if (current_sum == rem) {
                min_len = min(min_len, right - left + 1);
            }
        }

        if (min_len == INT_MAX) {
            return -1;
        }

        return k * n + min_len;
    }
};