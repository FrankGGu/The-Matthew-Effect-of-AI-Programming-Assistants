class Fancy {
private:
    const int MOD = 1e9 + 7;
    vector<long long> seq;
    vector<long long> add;
    vector<long long> mul;
    vector<long long> invMul;
    vector<long long> prefixMul;
    vector<long long> prefixAdd;

public:
    Fancy() {
        mul.push_back(1);
        invMul.push_back(1);
        add.push_back(0);
        prefixMul.push_back(1);
        prefixAdd.push_back(0);
    }

    void append(int val) {
        seq.push_back(val);
        mul.push_back(1);
        invMul.push_back(1);
        add.push_back(0);
        prefixMul.push_back(prefixMul.back());
        prefixAdd.push_back(prefixAdd.back());
    }

    void addAll(int inc) {
        if (!seq.empty()) {
            add.back() = (add.back() + inc) % MOD;
            prefixAdd.back() = (prefixAdd.back() + inc) % MOD;
        }
    }

    void multAll(int m) {
        if (!seq.empty()) {
            mul.back() = (mul.back() * m) % MOD;
            invMul.back() = powMod(mul.back(), MOD - 2);
            add.back() = (add.back() * m) % MOD;
            prefixMul.back() = (prefixMul.back() * m) % MOD;
            prefixAdd.back() = (prefixAdd.back() * m) % MOD;
        }
    }

    int getIndex(int idx) {
        if (idx >= seq.size()) return -1;
        long long m = (prefixMul.back() * powMod(prefixMul[idx], MOD - 2)) % MOD;
        long long a = (prefixAdd.back() - prefixAdd[idx] * m % MOD + MOD) % MOD;
        return (seq[idx] * m % MOD + a) % MOD;
    }

private:
    long long powMod(long long x, long long y) {
        long long res = 1;
        while (y > 0) {
            if (y & 1) res = (res * x) % MOD;
            x = (x * x) % MOD;
            y >>= 1;
        }
        return res;
    }
};