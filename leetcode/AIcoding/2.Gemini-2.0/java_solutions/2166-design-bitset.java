class Bitset {
    private char[] bits;
    private int size;
    private int ones;

    public Bitset(int size) {
        this.size = size;
        this.bits = new char[size];
        this.ones = 0;
        for (int i = 0; i < size; i++) {
            bits[i] = '0';
        }
    }

    public void fix(int idx) {
        if (bits[idx] == '0') {
            bits[idx] = '1';
            ones++;
        }
    }

    public void unfix(int idx) {
        if (bits[idx] == '1') {
            bits[idx] = '0';
            ones--;
        }
    }

    public void flip() {
        for (int i = 0; i < size; i++) {
            bits[i] = (bits[i] == '0') ? '1' : '0';
        }
        ones = size - ones;
    }

    public boolean all() {
        return ones == size;
    }

    public boolean one() {
        return ones > 0;
    }

    public int count() {
        return ones;
    }

    public String toString() {
        return new String(bits);
    }
}