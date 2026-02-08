class Solution {
public:
    int countAnagrams(string s) {
        const int MOD = 1e9 + 7;
        vector<int> factorial(26, 1);
        for (int i = 1; i < 26; ++i) {
            factorial[i] = factorial[i - 1] * (i + 1) % MOD;
        }

        auto modInverse = [&](int x) {
            int res = 1, a = x, b = MOD - 2;
            while (b) {
                if (b & 1) res = (res * a) % MOD;
                a = (a * a) % MOD;
                b >>= 1;
            }
            return res;
        };

        auto count = [&]() {
            unordered_map<char, int> freq;
            for (char c : s) freq[c]++;
            int total = factorial[s.size()];

            for (auto& [_, f] : freq) {
                total = (total * modInverse(factorial[f])) % MOD;
            }
            return total;
        };

        int result = 1;
        stringstream ss(s);
        string word;
        while (ss >> word) {
            result = (result * count()) % MOD;
        }

        return result;
    }
};