class MechanicalAccumulator {
    private int value;

    public MechanicalAccumulator() {
        value = 0;
    }

    public void add(int num) {
        value += num;
    }

    public int getValue() {
        return value;
    }

    public void reset() {
        value = 0;
    }
}