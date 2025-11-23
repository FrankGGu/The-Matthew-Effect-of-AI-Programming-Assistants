class Bitset {
    private int size;
    private int[] bits;
    private int flipCount;
    private int oneCount;

    public Bitset(int size) {
        this.size = size;
        this.bits = new int[size];
        this.flipCount = 0;
        this.oneCount = 0;
    }

    public void fix(int idx) {
        if ((bits[idx] + flipCount) % 2 == 0) {
            bits[idx]++;
            oneCount++;
        }
    }

    public void unfix(int idx) {
        if ((bits[idx] + flipCount) % 2 == 1) {
            bits[idx]--;
            oneCount--;
        }
    }

    public void flip() {
        flipCount++;
        oneCount = size - oneCount;
    }

    public boolean all() {
        return oneCount == size;
    }

    public boolean one() {
        return oneCount > 0;
    }

    public int count() {
        return oneCount;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < size; i++) {
            sb.append((bits[i] + flipCount) % 2);
        }
        return sb.toString();
    }
}