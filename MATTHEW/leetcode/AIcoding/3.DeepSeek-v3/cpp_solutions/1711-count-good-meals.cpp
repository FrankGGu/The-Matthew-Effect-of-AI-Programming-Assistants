class Solution {
public:
    int countPairs(vector<int>& deliciousness) {
        const int MOD = 1e9 + 7;
        unordered_map<int, int> freq;
        int res = 0;
        for (int num : deliciousness) {
            for (int p = 0; p <= 21; ++p) {
                int target = (1 << p) - num;
                if (freq.count(target)) {
                    res = (res + freq[target]) % MOD;
                }
            }
            freq[num]++;
        }
        return res;
    }
};