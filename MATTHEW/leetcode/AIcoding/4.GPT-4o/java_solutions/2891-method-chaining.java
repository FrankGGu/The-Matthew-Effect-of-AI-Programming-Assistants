class Chain {
    private int value;

    public Chain(int value) {
        this.value = value;
    }

    public Chain add(int num) {
        this.value += num;
        return this;
    }

    public Chain subtract(int num) {
        this.value -= num;
        return this;
    }

    public Chain multiply(int num) {
        this.value *= num;
        return this;
    }

    public int getValue() {
        return this.value;
    }
}