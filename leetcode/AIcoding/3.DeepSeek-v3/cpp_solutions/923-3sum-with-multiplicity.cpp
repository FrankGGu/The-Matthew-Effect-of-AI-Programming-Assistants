class Solution {
public:
    int threeSumMulti(vector<int>& arr, int target) {
        const int MOD = 1e9 + 7;
        long res = 0;
        unordered_map<int, long> count;
        for (int num : arr) count[num]++;

        for (auto it1 : count) {
            for (auto it2 : count) {
                int i = it1.first, j = it2.first, k = target - i - j;
                if (!count.count(k)) continue;
                if (i == j && j == k) {
                    res += count[i] * (count[i] - 1) * (count[i] - 2) / 6;
                } else if (i == j && j != k) {
                    res += count[i] * (count[i] - 1) / 2 * count[k];
                } else if (i < j && j < k) {
                    res += count[i] * count[j] * count[k];
                }
            }
        }
        return res % MOD;
    }
};