class Solution {
public:
    int countSpecialSubsequences(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        int n = nums.size();
        long long count0 = 0, count1 = 0, count2 = 0;

        for (int num : nums) {
            if (num == 0) {
                count0 = (count0 * 2 + 1) % MOD;
            } else if (num == 1) {
                count1 = (count1 * 2 + count0) % MOD;
            } else if (num == 2) {
                count2 = (count2 * 2 + count1) % MOD;
            }
        }

        return count2;
    }
};