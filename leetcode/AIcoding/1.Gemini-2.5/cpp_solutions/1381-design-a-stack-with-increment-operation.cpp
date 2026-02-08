#include <vector>
#include <numeric>
#include <algorithm>

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
        int val = stack.back();
        stack.pop_back();
        return val;
    }

    void increment(int k, int val) {
        int limit = std::min((int)stack.size(), k);
        for (int i = 0; i < limit; ++i) {
            stack[i] += val;
        }
    }
};