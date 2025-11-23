import java.util.ArrayList;
import java.util.List;

class Fancy {
    private List<Long> nums;
    private List<Long> add;
    private List<Long> mul;
    private long mod;

    public Fancy() {
        nums = new ArrayList<>();
        add = new ArrayList<>();
        mul = new ArrayList<>();
        mod = 1000000007;
        add.add(0L);
        mul.add(1L);
    }

    public void append(int a) {
        nums.add((long) a);
        add.add(0L);
        mul.add(1L);
    }

    public void addAll(int inc) {
        add.set(add.size() - 1, (add.get(add.size() - 1) + inc) % mod);
    }

    public void multiplyAll(int m) {
        long mulLast = mul.get(mul.size() - 1);
        long addLast = add.get(add.size() - 1);
        mul.add((mulLast * m) % mod);
        add.add((addLast * m) % mod);
    }

    public int getIndex(int i) {
        if (i >= nums.size()) {
            return -1;
        }
        long val = (nums.get(i) * mul.get(mul.size() - 1)) % mod;
        val = (val + add.get(add.size() - 1)) % mod;
        return (int) val;
    }
}