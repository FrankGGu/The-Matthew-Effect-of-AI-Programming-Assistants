class MechanicalAccumulator {
private:
    long long current_value;

public:
    MechanicalAccumulator() : current_value(0) {}

    void add(int val) {
        current_value += val;
    }

    void subtract(int val) {
        current_value -= val;
    }

    void multiply(int val) {
        current_value *= val;
    }

    void divide(int val) {
        if (val != 0) {
            current_value /= val;
        }
    }

    long long get_result() {
        return current_value;
    }

    void reset() {
        current_value = 0;
    }
};