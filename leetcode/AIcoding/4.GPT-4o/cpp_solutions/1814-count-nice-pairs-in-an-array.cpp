class Solution {
public:
    int countNicePairs(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        unordered_map<long long, long long> count;
        long long nicePairs = 0;

        for (int num : nums) {
            long long revNum = 0, original = num;
            while (original > 0) {
                revNum = revNum * 10 + original % 10;
                original /= 10;
            }
            nicePairs = (nicePairs + count[num - revNum]) % MOD;
            count[num - revNum]++;
        }

        return nicePairs;
    }
};