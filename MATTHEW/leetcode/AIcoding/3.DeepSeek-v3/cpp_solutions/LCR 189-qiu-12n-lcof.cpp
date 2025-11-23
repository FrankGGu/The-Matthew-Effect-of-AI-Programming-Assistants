class Accumulator {
private:
    int total;
public:
    Accumulator() {
        total = 0;
    }

    int add(int num) {
        total += num;
        return total;
    }

    int reset() {
        int prev = total;
        total = 0;
        return prev;
    }
};