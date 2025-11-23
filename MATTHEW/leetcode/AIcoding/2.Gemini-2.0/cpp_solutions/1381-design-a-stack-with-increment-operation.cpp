#include <vector>

class CustomStack {
private:
    std::vector<int> stack;
    int maxSize;

public:
    CustomStack(int maxSize) {
        this->maxSize = maxSize;
    }

    void push(int x) {
        if (stack.size() < maxSize) {
            stack.push_back(x);
        }
    }

    int pop() {
        if (stack.empty()) {
            return -1;
        }
        int top = stack.back();
        stack.pop_back();
        return top;
    }

    void increment(int k, int val) {
        int incrementSize = std::min((int)stack.size(), k);
        for (int i = 0; i < incrementSize; ++i) {
            stack[i] += val;
        }
    }
};