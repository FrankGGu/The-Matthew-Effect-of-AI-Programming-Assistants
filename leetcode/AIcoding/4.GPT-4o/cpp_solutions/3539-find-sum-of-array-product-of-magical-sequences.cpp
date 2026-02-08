class Solution {
public:
    int magicalSequences(vector<int>& nums) {
        int n = nums.size();
        long long mod = 1e9 + 7;
        long long sum = 0;

        for (int i = 0; i < n; ++i) {
            long long product = 1;
            for (int j = i; j < n; ++j) {
                product = (product * nums[j]) % mod;
                sum = (sum + product) % mod;
            }
        }

        return sum;
    }
};