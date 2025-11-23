class Solution {
public:
    int countPairs(vector<int>& deliciousness) {
        const int MOD = 1e9 + 7;
        unordered_map<int, long long> count;
        long long result = 0;

        for (int dish : deliciousness) {
            for (int i = 0; i < 22; ++i) {
                int target = (1 << i) - dish;
                if (count.find(target) != count.end()) {
                    result = (result + count[target]) % MOD;
                }
            }
            count[dish]++;
        }

        return result;
    }
};