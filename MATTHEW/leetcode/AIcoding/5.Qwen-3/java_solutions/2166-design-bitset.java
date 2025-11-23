public class Bitset {
    private int[] bits;
    private int size;
    private int count1;
    private boolean flipped;

    public Bitset(int size) {
        this.size = size;
        this.bits = new int[(size + 31) / 32];
        this.count1 = 0;
        this.flipped = false;
    }

    public void fix(int idx) {
        if (flipped) {
            if ((bits[idx / 32] & (1 << (idx % 32))) == 0) {
                bits[idx / 32] |= (1 << (idx % 32));
                count1++;
            }
        } else {
            if ((bits[idx / 32] & (1 << (idx % 32))) == 0) {
                bits[idx / 32] |= (1 << (idx % 32));
                count1++;
            }
        }
    }

    public void unfix(int idx) {
        if (flipped) {
            if ((bits[idx / 32] & (1 << (idx % 32))) != 0) {
                bits[idx / 32] ^= (1 << (idx % 32));
                count1--;
            }
        } else {
            if ((bits[idx / 32] & (1 << (idx % 32))) != 0) {
                bits[idx / 32] ^= (1 << (idx % 32));
                count1--;
            }
        }
    }

    public void flip() {
        flipped = !flipped;
        count1 = size - count1;
    }

    public boolean all() {
        return count1 == size;
    }

    public boolean any() {
        return count1 > 0;
    }

    public int[] toArray() {
        int[] result = new int[size];
        for (int i = 0; i < size; i++) {
            if (flipped) {
                result[i] = (bits[i / 32] & (1 << (i % 32))) == 0 ? 1 : 0;
            } else {
                result[i] = (bits[i / 32] & (1 << (i % 32))) != 0 ? 1 : 0;
            }
        }
        return result;
    }

    public int bitCount() {
        return count1;
    }

    public int size() {
        return size;
    }
}