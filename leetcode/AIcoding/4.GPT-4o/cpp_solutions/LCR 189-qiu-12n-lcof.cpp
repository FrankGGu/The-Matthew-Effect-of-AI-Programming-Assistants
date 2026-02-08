class MechanicalAccumulator {
public:
    MechanicalAccumulator() : total(0) {}

    void add(int x) {
        total += x;
    }

    int get() {
        return total;
    }

private:
    int total;
};