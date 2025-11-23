class Solution {
public:
    int countWays(vector<vector<int>>& corridors) {
        int n = corridors.size();
        if (n % 2 != 0) return 0;
        long long mod = 1e9 + 7;
        long long ways = 1;

        for (int i = 0; i < n; i += 2) {
            ways = (ways * (corridors[i][1] - corridors[i][0])) % mod;
        }

        return ways;
    }
};