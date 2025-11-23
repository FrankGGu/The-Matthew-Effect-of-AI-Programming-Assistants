class Solution {
public:
    int numberOfGoodSubarraySplits(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        vector<int> ones;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == 1) {
                ones.push_back(i);
            }
        }
        if (ones.empty()) {
            return 0;
        }
        long long res = 1;
        for (int i = 1; i < ones.size(); ++i) {
            res = (res * (ones[i] - ones[i-1])) % MOD;
        }
        return res;
    }
};