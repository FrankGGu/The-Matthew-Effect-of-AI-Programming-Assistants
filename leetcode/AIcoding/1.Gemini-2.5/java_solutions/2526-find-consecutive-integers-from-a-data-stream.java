class DataStream {
    private int value;
    private int k;
    private int count;

    public DataStream(int value, int k) {
        this.value = value;
        this.k = k;
        this.count = 0;
    }

    public boolean consec(int num) {
        if (num == this.value) {
            this.count++;
        } else {
            this.count = 0;
        }
        return this.count >= this.k;
    }
}