class Solution {
public:
    int countPairs(vector<int>& deliciousness) {
        unordered_map<int, int> count;
        long long result = 0;
        const int MOD = 1e9 + 7;

        for (int num : deliciousness) {
            for (int i = 0; i <= 21; i++) {
                int target = (1 << i) - num;
                if (count.find(target) != count.end()) {
                    result = (result + count[target]) % MOD;
                }
            }
            count[num]++;
        }

        return result;
    }
};