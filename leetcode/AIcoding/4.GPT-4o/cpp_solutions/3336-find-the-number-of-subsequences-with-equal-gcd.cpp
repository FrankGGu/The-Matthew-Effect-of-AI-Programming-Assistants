class Solution {
public:
    int countSubsequences(vector<int>& nums, int gcdVal) {
        int n = nums.size();
        long long mod = 1e9 + 7;
        sort(nums.begin(), nums.end());
        vector<int> count(1001, 0);
        for (int num : nums) {
            count[num]++;
        }

        long long result = 0;
        for (int g = 1; g <= 1000; g++) {
            if (gcdVal % g == 0) {
                long long totalCount = 0;
                for (int multiple = g; multiple <= 1000; multiple += g) {
                    totalCount += count[multiple];
                }
                if (totalCount > 0) {
                    long long ways = (1LL << totalCount) - 1; // 2^totalCount - 1
                    result = (result + ways) % mod;
                }
            }
        }

        return result;
    }
};