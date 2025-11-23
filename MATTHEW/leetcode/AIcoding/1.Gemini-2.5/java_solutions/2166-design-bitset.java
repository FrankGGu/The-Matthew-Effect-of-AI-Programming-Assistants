class Bitset {
    private boolean[] bits;
    private int size;
    private int countOnes;
    private boolean isFlipped;

    public Bitset(int size) {
        this.size = size;
        this.bits = new boolean[size];
        this.countOnes = 0;
        this.isFlipped = false;
    }

    public void fix(int idx) {
        if (isFlipped) {
            // If flipped, bits[idx] being true means actual bit is 0.
            // To fix to 1, we need actual bit to be 1.
            // So, bits[idx] should become false.
            if (bits[idx]) { // If current actual bit is 0
                bits[idx] = false; // Set actual bit to 1
                countOnes++;
            }
        } else {
            // If not flipped, bits[idx] being true means actual bit is 1.
            // To fix to 1, we need actual bit to be 1.
            // So, bits[idx] should become true.
            if (!bits[idx]) { // If current actual bit is 0
                bits[idx] = true; // Set actual bit to 1
                countOnes++;
            }
        }
    }

    public void unfix(int idx) {
        if (isFlipped) {
            // If flipped, bits[idx] being true means actual bit is 0.
            // To unfix to 0, we need actual bit to be 0.
            // So, bits[idx] should become true.
            if (!bits[idx]) { // If current actual bit is 1
                bits[idx] = true; // Set actual bit to 0
                countOnes--;
            }
        } else {
            // If not flipped, bits[idx] being true means actual bit is 1.
            // To unfix to 0, we need actual bit to be 0.
            // So, bits[idx] should become false.
            if (bits[idx]) { // If current actual bit is 1
                bits[idx] = false; // Set actual bit to 0
                countOnes--;
            }
        }
    }

    public void flip() {
        isFlipped = !isFlipped;
        countOnes = size - countOnes;
    }

    public int count() {
        return countOnes;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < size; i++) {
            if (isFlipped) {
                sb.append(bits[i] ? '0' : '1');
            } else {
                sb.append(bits[i] ? '1' : '0');
            }
        }
        return sb.toString();
    }
}