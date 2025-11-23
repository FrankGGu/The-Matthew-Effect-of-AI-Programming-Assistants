class Solution {
public:
    long long wonderfulSubstrings(string word) {
        long long res = 0;
        int mask = 0;
        unordered_map<int, int> count;
        count[0] = 1;

        for (char c : word) {
            mask ^= 1 << (c - 'a');
            res += count[mask];
            for (int i = 0; i < 10; ++i) {
                res += count[mask ^ (1 << i)];
            }
            count[mask]++;
        }
        return res;
    }
};