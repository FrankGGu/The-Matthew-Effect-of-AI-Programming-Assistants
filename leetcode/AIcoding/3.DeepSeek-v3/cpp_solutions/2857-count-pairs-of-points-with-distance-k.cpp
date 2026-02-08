class Solution {
public:
    int countPairs(vector<vector<int>>& coordinates, int k) {
        unordered_map<long long, int> freq;
        int res = 0;
        for (const auto& coord : coordinates) {
            int x = coord[0], y = coord[1];
            for (int a = 0; a <= k; ++a) {
                int b = k - a;
                long long target_x = x ^ a;
                long long target_y = y ^ b;
                long long key = (target_x << 32) | target_y;
                if (freq.count(key)) {
                    res += freq[key];
                }
            }
            long long key = ((long long)x << 32) | y;
            freq[key]++;
        }
        return res;
    }
};