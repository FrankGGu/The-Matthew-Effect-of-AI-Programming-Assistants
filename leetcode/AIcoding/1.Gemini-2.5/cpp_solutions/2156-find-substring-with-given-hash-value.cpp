class Solution {
public:
    long long power(long long base, long long exp, long long mod) {
        long long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp /= 2;
        }
        return res;
    }

    string subStrHash(string s, int power_val, int modulo, int k, int hashValue) {
        int n = s.length();
        long long p = power_val;
        long long m = modulo;
        long long target_hash = hashValue;

        long long pk_minus_1 = power(p, k - 1, m);

        long long current_hash = 0;
        long long current_p_power = 1;

        for (int j = 0; j < k; ++j) {
            current_hash = (current_hash + (long long)(s[n - k + j] - 'a') * current_p_power) % m;
            current_p_power = (current_p_power * p) % m;
        }

        int ans_idx = n - k; 

        if (current_hash == target_hash) {
            ans_idx = n - k;
        }

        for (int i = n - k - 1; i >= 0; --i) {
            current_hash = (current_hash - (long long)(s[i + k] - 'a') * pk_minus_1) % m;
            current_hash = (current_hash + m) % m; 

            current_hash = (current_hash * p) % m;

            current_hash = (current_hash + (s[i] - 'a')) % m;

            if (current_hash == target_hash) {
                ans_idx = i;
            }
        }

        return s.substr(ans_idx, k);
    }
};