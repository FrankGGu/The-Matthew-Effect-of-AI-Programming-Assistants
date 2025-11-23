class Calculator {
    private int result;

    public Calculator(int num) {
        this.result = num;
    }

    public Calculator add(int num) {
        this.result += num;
        return this;
    }

    public Calculator subtract(int num) {
        this.result -= num;
        return this;
    }

    public Calculator multiply(int num) {
        this.result *= num;
        return this;
    }

    public Calculator divide(int num) {
        if (num == 0) {
            this.result = 0; // Or throw an exception, based on requirements
        } else {
            this.result /= num;
        }
        return this;
    }

    public int getResult() {
        return this.result;
    }
}