class DataFrame {
    private int rows;
    private int cols;

    public DataFrame(int rows, int cols) {
        this.rows = rows;
        this.cols = cols;
    }

    public int getSize() {
        return rows * cols;
    }
}