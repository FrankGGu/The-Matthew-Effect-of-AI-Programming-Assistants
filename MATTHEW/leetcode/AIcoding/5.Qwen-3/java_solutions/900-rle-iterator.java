public class RLEIterator {
    private int[] encoding;
    private int index;

    public RLEIterator(int[] encoding) {
        this.encoding = encoding;
        this.index = 0;
    }

    public int next(int n) {
        while (index < encoding.length && n > 0) {
            if (encoding[index] >= n) {
                encoding[index] -= n;
                return encoding[index + 1];
            } else {
                n -= encoding[index];
                index += 2;
            }
        }
        return -1;
    }
}