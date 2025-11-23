class Calculator {
private:
    int current_value;

public:
    Calculator(int initial_value = 0) : current_value(initial_value) {}

    Calculator& add(int num) {
        current_value += num;
        return *this;
    }

    Calculator& subtract(int num) {
        current_value -= num;
        return *this;
    }

    Calculator& multiply(int num) {
        current_value *= num;
        return *this;
    }

    Calculator& divide(int num) {
        if (num != 0) {
            current_value /= num;
        }
        return *this;
    }

    int getValue() {
        return current_value;
    }
};