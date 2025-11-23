class Calculator {
    private int value;

    public Calculator() {
        this.value = 0;
    }

    public Calculator(int initialValue) {
        this.value = initialValue;
    }

    public Calculator add(int num) {
        this.value += num;
        return this;
    }

    public Calculator subtract(int num) {
        this.value -= num;
        return this;
    }

    public Calculator multiply(int num) {
        this.value *= num;
        return this;
    }

    public Calculator divide(int num) {
        if (num == 0) {
            throw new IllegalArgumentException("Cannot divide by zero");
        }
        this.value /= num;
        return this;
    }

    public int getValue() {
        return this.value;
    }
}