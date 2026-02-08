class Solution {
public:
    long long sumDigitDifferences(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0;
        long long res = 0;
        int max_digits = to_string(nums[0]).length();
        for (int d = 0; d < max_digits; ++d) {
            vector<int> cnt(10, 0);
            for (int num : nums) {
                int digit = (num / (int)pow(10, d)) % 10;
                cnt[digit]++;
            }
            for (int i = 0; i < 10; ++i) {
                for (int j = i + 1; j < 10; ++j) {
                    res += (long long)cnt[i] * cnt[j];
                }
            }
        }
        return res;
    }
};