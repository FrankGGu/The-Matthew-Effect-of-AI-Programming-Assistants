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
            prefix[i + 1] = (prefix[i] * 1LL * powers[i]) % 1000000007;
        }

        vector<int> result;
        for (const auto& query : queries) {
            int l = query[0], r = query[1];
            long long product = (prefix[r + 1] * 1LL * modInverse(prefix[l], 1000000007)) % 1000000007;
            result.push_back(product);
        }
        return result;
    }

private:
    long long modInverse(long long a, int m) {
        return power(a, m - 2, m);
    }

    long long power(long long x, int y, int m) {
        long long res = 1;
        x = x % m;
        while (y > 0) {
            if (y & 1) {
                res = (res * x) % m;
            }
            y = y >> 1;
            x = (x * x) % m;
        }
        return res;
    }
};