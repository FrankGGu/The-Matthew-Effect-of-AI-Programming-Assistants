class Fancy {
    private static final int MOD = 1_000_000_007;
    private List<Integer> sequence;
    private long add;
    private long mul;

    public Fancy() {
        sequence = new ArrayList<>();
        add = 0;
        mul = 1;
    }

    public void append(int val) {
        long adjustedVal = (val - add + MOD) % MOD;
        adjustedVal = (adjustedVal * modInverse(mul, MOD)) % MOD;
        sequence.add((int) adjustedVal);
    }

    public void addAll(int inc) {
        add = (add + inc) % MOD;
    }

    public void multAll(int m) {
        add = (add * m) % MOD;
        mul = (mul * m) % MOD;
    }

    public int getIndex(int idx) {
        if (idx >= sequence.size()) {
            return -1;
        }
        long val = sequence.get(idx);
        long res = (val * mul) % MOD;
        res = (res + add) % MOD;
        return (int) res;
    }

    private long modInverse(long a, int mod) {
        long m = mod;
        long y = 0, x = 1;
        if (mod == 1) {
            return 0;
        }
        while (a > 1) {
            long q = a / mod;
            long t = mod;
            mod = (int) (a % mod);
            a = t;
            t = y;
            y = x - q * y;
            x = t;
        }
        if (x < 0) {
            x += m;
        }
        return x;
    }
}