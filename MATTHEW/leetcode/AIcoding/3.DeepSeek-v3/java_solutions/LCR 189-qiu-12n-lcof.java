class Machine {
    private int sum;

    public Machine() {
        sum = 0;
    }

    public int add(int x) {
        sum += x;
        return sum;
    }

    public int reset() {
        int prevSum = sum;
        sum = 0;
        return prevSum;
    }
}