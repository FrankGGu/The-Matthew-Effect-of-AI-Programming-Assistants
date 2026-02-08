#include <stack>
#include <algorithm>

class MinStack {
public:
    std::stack<int> s_main;
    std::stack<int> s_min;

    MinStack() {

    }

    void push(int val) {
        s_main.push(val);
        if (s_min.empty() || val <= s_min.top()) {
            s_min.push(val);
        }
    }

    void pop() {
        if (s_main.top() == s_min.top()) {
            s_min.pop();
        }
        s_main.pop();
    }

    int top() {
        return s_main.top();
    }

    int getMin() {
        return s_min.top();
    }
};