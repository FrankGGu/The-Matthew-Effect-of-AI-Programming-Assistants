class Fancy {
public:
    vector<long long> A;
    vector<long long> add, mul;
    long long mod = 1e9 + 7;

    Fancy() {
        A.resize(0);
        add.resize(1, 0);
        mul.resize(1, 1);
    }

    void append(int a) {
        A.push_back(a);
        add.push_back(0);
        mul.push_back(1);
    }

    void addAll(int inc) {
        add.back() = (add.back() + inc) % mod;
    }

    void multAll(int m) {
        add.back() = (add.back() * m) % mod;
        mul.back() = (mul.back() * m) % mod;
    }

    int getIndex(int i) {
        if (i >= A.size()) return -1;
        long long res = (A[i] * mul.back() % mod + add.back()) % mod;
        for (int j = 0; j < i; ++j) {
            res = (res * mul[j] % mod + add[j]) % mod;
        }
        return res;
    }
};