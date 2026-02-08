class Fancy {
    private long[] arr;
    private long add;
    private long mul;
    private int size;
    private static final int MOD = 1000000007;

    public Fancy() {
        arr = new long[100001];
        add = 0;
        mul = 1;
        size = 0;
    }

    public void append(int val) {
        arr[size] = (val - add + MOD) % MOD * modInverse(mul, MOD) % MOD;
        size++;
    }

    public void addAll(int inc) {
        add = (add + inc) % MOD;
    }

    public void multAll(int m) {
        mul = (mul * m) % MOD;
        add = (add * m) % MOD;
    }

    public int getIndex(int idx) {
        if (idx >= size) {
            return -1;
        }
        return (int) ((arr[idx] * mul % MOD + add) % MOD);
    }

    private long modInverse(long a, long m) {
        return power(a, m - 2, m);
    }

    private long power(long base, long exp, long mod) {
        long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp >>= 1;
        }
        return res;
    }
}