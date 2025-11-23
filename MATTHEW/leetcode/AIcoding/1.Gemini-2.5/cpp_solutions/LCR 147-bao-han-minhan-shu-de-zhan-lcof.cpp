#include <stack>

class MinStack {
public:
    std::stack<int> data_stack;
    std::stack<int> min_stack;

    MinStack() {

    }

    void push(int val) {
        data_stack.push(val);
        if (min_stack.empty() || val <= min_stack.top()) {
            min_stack.push(val);
        }
    }

    void pop() {
        if (data_stack.top() == min_stack.top()) {
            min_stack.pop();
        }
        data_stack.pop();
    }

    int top() {
        return data_stack.top();
    }

    int getMin() {
        return min_stack.top();
    }
};