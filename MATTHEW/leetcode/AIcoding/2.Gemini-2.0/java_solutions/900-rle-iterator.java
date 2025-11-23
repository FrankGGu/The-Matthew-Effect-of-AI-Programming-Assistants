class RLEIterator {

    int[] encoding;
    int index;
    int count;

    public RLEIterator(int[] encoding) {
        this.encoding = encoding;
        this.index = 0;
        this.count = 0;
    }

    public int next(int n) {
        while (index < encoding.length && n > 0) {
            if (count == 0) {
                count = encoding[index];
            }

            int take = Math.min(n, count);
            count -= take;
            n -= take;

            if (count == 0) {
                index += 2;
            }
        }

        if (n == 0 && count > 0) {
            return encoding[index - 1];
        } else if (n == 0 && index >= encoding.length) {
            return -1;
        } else if (index >= encoding.length) {
            return -1;
        } else {
            return encoding[index - 1];
        }
    }
}