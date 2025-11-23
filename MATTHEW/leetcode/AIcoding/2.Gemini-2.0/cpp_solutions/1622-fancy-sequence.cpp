class Fancy {
private:
    vector<long long> arr;
    long long mul;
    long long add;
    int mod = 1e9 + 7;

public:
    Fancy() : arr(), mul(1), add(0) {}

    void append(int val) {
        arr.push_back((val - add + mod) % mod * pow_mod(mul, mod - 2, mod) % mod);
    }

    void addAll(int inc) {
        add = (add + inc) % mod;
    }

    void multAll(int m) {
        mul = (mul * m) % mod;
        add = (add * m) % mod;
    }

    int getIndex(int idx) {
        if (idx >= arr.size()) {
            return -1;
        }
        return (arr[idx] * mul % mod + add) % mod;
    }

private:
    long long pow_mod(long long base, long long exp, long long mod) {
        long long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp /= 2;
        }
        return res;
    }
};