class Solution {
public:
    vector<int> productQueries(int n, vector<vector<int>>& queries) {
        vector<int> powers;
        for (int i = 0; i < 32; ++i) {
            if (n & (1 << i)) {
                powers.push_back(1 << i);
            }
        }

        vector<int> prefix(powers.size() + 1, 1);
        for (int i = 0; i < powers.size(); ++i) {
            prefix[i + 1] = (1LL * prefix[i] * powers[i]) % 1000000007;
        }

        vector<int> result;
        for (auto& query : queries) {
            int l = query[0], r = query[1];
            long long product = (prefix[r + 1] * 1LL * modInverse(prefix[l], 1000000007)) % 1000000007;
            result.push_back(product);
        }
        return result;
    }

private:
    int modInverse(int a, int m) {
        int m0 = m;
        int y = 0, x = 1;
        if (m == 1) return 0;

        while (a > 1) {
            int q = a / m;
            int t = m;
            m = a % m;
            a = t;
            t = y;
            y = x - q * y;
            x = t;
        }
        if (x < 0) x += m0;
        return x;
    }
};