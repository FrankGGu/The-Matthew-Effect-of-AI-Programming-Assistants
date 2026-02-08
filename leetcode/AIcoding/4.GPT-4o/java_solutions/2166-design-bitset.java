class Bitset {
    private boolean[] bits;
    private int count;
    private boolean flipped;

    public Bitset(int size) {
        bits = new boolean[size];
        count = 0;
        flipped = false;
    }

    public void fix(int idx) {
        if (flipped) {
            if (bits[idx]) {
                bits[idx] = false;
                count--;
            } else {
                bits[idx] = true;
                count++;
            }
        } else {
            if (!bits[idx]) {
                bits[idx] = true;
                count++;
            }
        }
    }

    public void unfix(int idx) {
        if (flipped) {
            if (!bits[idx]) {
                bits[idx] = true;
                count--;
            } else {
                bits[idx] = false;
                count++;
            }
        } else {
            if (bits[idx]) {
                bits[idx] = false;
                count--;
            }
        }
    }

    public void flip() {
        flipped = !flipped;
        count = bits.length - count;
    }

    public boolean all() {
        return count == bits.length;
    }

    public boolean one() {
        return count > 0;
    }

    public int count() {
        return count;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (boolean bit : bits) {
            sb.append(flipped ? !bit : bit ? '1' : '0');
        }
        return sb.toString();
    }
}