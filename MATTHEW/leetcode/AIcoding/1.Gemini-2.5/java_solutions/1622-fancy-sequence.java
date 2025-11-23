import java.util.ArrayList;
import java.util.List;

class Fancy {

    private static final int MOD = 1_000_000_007;

    private List<Long> values;
    private List<Long> mAtAppend; // current_mult_global at time of append
    private List<Long> aAtAppend; // current_add_global at time of append

    private long currentMultGlobal;
    private long currentAddGlobal;

    public Fancy() {
        values = new ArrayList<>();
        mAtAppend = new ArrayList<>();
        aAtAppend = new ArrayList<>();
        currentMultGlobal = 1;
        currentAddGlobal = 0;
    }

    public void append(int val) {
        values.add((long) val);
        mAtAppend.add(currentMultGlobal);
        aAtAppend.add(currentAddGlobal);
    }

    public void addAll(int inc) {
        currentAddGlobal = (currentAddGlobal + inc) % MOD;
    }

    public void multAll(int m) {
        currentMultGlobal = (currentMultGlobal * m) % MOD;
        currentAddGlobal = (currentAddGlobal * m) % MOD;
    }

    public int getIndex(int idx) {
        if (idx >= values.size()) {
            return -1;
        }

        long originalVal = values.get(idx);
        long mStart = mAtAppend.get(idx);
        long aStart = aAtAppend.get(idx);

        long mEnd = currentMultGlobal;
        long aEnd = currentAddGlobal;

        long mDiff;
        long aDiff;

        if (mStart == 0) {
            // If mStart was 0, it means a multAll(0) happened before this element was appended.
            // At that point, currentMultGlobal became 0 and currentAddGlobal became 0.
            // So mStart must be 0 and aStart must be 0.
            // After this, currentMultGlobal remains 0.
            // currentAddGlobal can change only due to addAll operations.
            // The effective transformation on originalVal is just adding the net change in aGlobal.
            // Net change in aGlobal = aEnd - aStart. Since aStart is 0, it's just aEnd.
            // So, originalVal becomes (originalVal + aEnd) % MOD.
            return (int) ((originalVal + aEnd) % MOD);
        } else {
            // General case: f_end(x) = f_diff(f_start(x))
            // x * M_end + A_end = (x * M_start + A_start) * M_diff + A_diff
            // Comparing coefficients:
            // 1) M_end = M_start * M_diff
            // 2) A_end = A_start * M_diff + A_diff

            mDiff = (mEnd * modInverse(mStart)) % MOD;
            aDiff = (aEnd - (aStart * mDiff) % MOD + MOD) % MOD;

            return (int) ((originalVal * mDiff + aDiff) % MOD);
        }
    }

    // Modular exponentiation: (base^exp) % mod
    private long power(long base, long exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    // Modular inverse using Fermat's Little Theorem: a^(MOD-2) % MOD
    private long modInverse(long n) {
        return power(n, MOD - 2);
    }
}