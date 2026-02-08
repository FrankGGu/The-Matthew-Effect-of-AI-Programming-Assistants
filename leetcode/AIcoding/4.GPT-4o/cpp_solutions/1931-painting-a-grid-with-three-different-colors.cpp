class Solution {
public:
    int colorTheGrid(int m, int n) {
        const int MOD = 1e9 + 7;
        vector<vector<long long>> dp(n + 1, vector<long long>(1 << (2 * m), 0));
        vector<int> validMasks = getValidMasks(m);

        for (int mask : validMasks) {
            dp[1][mask] = 1;
        }

        for (int col = 2; col <= n; ++col) {
            for (int mask : validMasks) {
                for (int nextMask : validMasks) {
                    if (isValidTransition(mask, nextMask, m)) {
                        dp[col][nextMask] = (dp[col][nextMask] + dp[col - 1][mask]) % MOD;
                    }
                }
            }
        }

        long long result = 0;
        for (int mask : validMasks) {
            result = (result + dp[n][mask]) % MOD;
        }

        return result;
    }

private:
    vector<int> getValidMasks(int m) {
        vector<int> masks;
        int maxMask = 1 << (2 * m);
        for (int mask = 0; mask < maxMask; ++mask) {
            if (isValidMask(mask, m)) {
                masks.push_back(mask);
            }
        }
        return masks;
    }

    bool isValidMask(int mask, int m) {
        vector<int> colors(m);
        for (int i = 0; i < m; ++i) {
            colors[i] = (mask >> (2 * i)) & 3;
            if (colors[i] > 0 && (i > 0 && colors[i] == colors[i - 1])) {
                return false;
            }
        }
        return true;
    }

    bool isValidTransition(int mask, int nextMask, int m) {
        for (int i = 0; i < m; ++i) {
            if (((mask >> (2 * i)) & 3) == ((nextMask >> (2 * i)) & 3)) {
                return false;
            }
        }
        return true;
    }
};