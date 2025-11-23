class Solution {
public:
    int sumDistance(vector<int>& nums, string s, int d) {
        const int MOD = 1e9 + 7;
        int n = nums.size();
        vector<long long> finalPos(n);
        for (int i = 0; i < n; ++i) {
            if (s[i] == 'L') {
                finalPos[i] = nums[i] - d;
            } else {
                finalPos[i] = nums[i] + d;
            }
        }
        sort(finalPos.begin(), finalPos.end());
        long long res = 0;
        long long prefix = 0;
        for (int i = 0; i < n; ++i) {
            res = (res + finalPos[i] * i - prefix) % MOD;
            prefix = (prefix + finalPos[i]) % MOD;
        }
        return res;
    }
};