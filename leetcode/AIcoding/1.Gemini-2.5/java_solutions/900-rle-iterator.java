class RLEIterator {
    int[] encoding;
    int ptr;

    public RLEIterator(int[] A) {
        this.encoding = A;
        this.ptr = 0;
    }

    public int next(int n) {
        while (ptr < encoding.length) {
            if (encoding[ptr] >= n) {
                encoding[ptr] -= n;
                return encoding[ptr + 1];
            } else {
                n -= encoding[ptr];
                ptr += 2;
            }
        }
        return -1;
    }
}