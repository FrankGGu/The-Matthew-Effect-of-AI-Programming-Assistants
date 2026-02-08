class Solution {
public:
    long long countPairs(vector<int>& nums, int k) {
        unordered_map<int, int> gcdCount;
        long long res = 0;
        for (int num : nums) {
            int gcd1 = __gcd(num, k);
            for (auto& [gcd2, cnt] : gcdCount) {
                if ((long long)gcd1 * gcd2 % k == 0) {
                    res += cnt;
                }
            }
            gcdCount[gcd1]++;
        }
        return res;
    }
};