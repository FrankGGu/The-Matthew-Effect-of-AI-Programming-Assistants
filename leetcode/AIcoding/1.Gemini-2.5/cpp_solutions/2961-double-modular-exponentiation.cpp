class Solution {
public:
    long long power(long long base, long long exp, long long mod) {
        long long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % mod;
            }
            base = (base * base) % mod;
            exp /= 2;
        }
        return res;
    }

    vector<int> getGoodIndices(vector<vector<int>>& variables, int target) {
        vector<int> goodIndices;
        for (int i = 0; i < variables.size(); ++i) {
            long long base = variables[i][0];
            long long exp = variables[i][1];
            long long mod = variables[i][2];

            long long val = power(base, exp, mod);

            if (val % 10 == target) {
                goodIndices.push_back(i);
            }
        }
        return goodIndices;
    }
};