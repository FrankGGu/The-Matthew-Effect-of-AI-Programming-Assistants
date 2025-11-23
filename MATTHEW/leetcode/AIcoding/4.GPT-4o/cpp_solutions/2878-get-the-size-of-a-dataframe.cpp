class DataFrame {
public:
    DataFrame(int rows, int cols) : rows(rows), cols(cols) {}

    int getSize() {
        return rows * cols;
    }

private:
    int rows;
    int cols;
};