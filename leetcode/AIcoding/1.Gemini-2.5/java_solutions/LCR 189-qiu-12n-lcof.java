class Accumulator {
    private long currentSum;

    public Accumulator() {
        currentSum = 0;
    }

    public void add(int val) {
        currentSum += val;
    }

    public long sum() {
        return currentSum;
    }
}