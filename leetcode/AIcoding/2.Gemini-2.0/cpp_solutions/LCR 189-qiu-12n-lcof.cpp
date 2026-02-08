class Accumulator {
private:
    long long sum;

public:
    Accumulator() : sum(0) {}

    void add(int num) {
        sum += num;
    }

    int getSum() {
        return sum;
    }
};