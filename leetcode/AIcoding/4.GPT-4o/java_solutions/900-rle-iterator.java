class RLEIterator {
    private int[] A;
    private int index = 0;
    private int count = 0;

    public RLEIterator(int[] A) {
        this.A = A;
    }

    public int next(int n) {
        while (index < A.length) {
            if (count + n <= A[index]) {
                count += n;
                return A[index + 1];
            } else {
                n -= (A[index] - count);
                count = 0;
                index += 2;
            }
        }
        return -1;
    }
}