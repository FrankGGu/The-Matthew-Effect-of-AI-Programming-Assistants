#include <vector>

class Fancy {
private:
    std::vector<long long> seq;
    long long add_term;
    long long mul_term;
    const int MOD = 1e9 + 7;

    long long power(long long base, long long exp) {
        long long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    long long modInverse(long long n) {
        return power(n, MOD - 2);
    }

public:
    Fancy() {
        add_term = 0;
        mul_term = 1;
    }

    void append(int val) {
        long long v = val;
        long long temp_add = (v - add_term + MOD) % MOD;
        long long inv_mul = modInverse(mul_term);
        long long normalized_val = (temp_add * inv_mul) % MOD;
        seq.push_back(normalized_val);
    }

    void addAll(int inc) {
        add_term = (add_term + inc) % MOD;
    }

    void multAll(int m) {
        mul_term = (mul_term * m) % MOD;
        add_term = (add_term * m) % MOD;
    }

    int getIndex(int idx) {
        if (idx >= seq.size()) {
            return -1;
        }
        long long val = seq[idx];
        long long result = (val * mul_term + add_term) % MOD;
        return static_cast<int>(result);
    }
};