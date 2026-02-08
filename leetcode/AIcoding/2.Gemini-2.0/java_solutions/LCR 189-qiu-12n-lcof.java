class Accumulator {

    private int currentValue = 0;

    public Accumulator() {

    }

    public void accumulate(int val) {
        currentValue += val;
    }

    public int getResult() {
        return currentValue;
    }

    public void reset() {
        currentValue = 0;
    }
}