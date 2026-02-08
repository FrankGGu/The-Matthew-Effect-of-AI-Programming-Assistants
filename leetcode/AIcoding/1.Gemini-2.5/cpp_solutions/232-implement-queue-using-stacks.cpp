#include <stack>

class MyQueue {
private:
    std::stack<int> inStack;
    std::stack<int> outStack;

    void transferElements() {
        if (outStack.empty()) {
            while (!inStack.empty()) {
                outStack.push(inStack.top());
                inStack.pop();
            }
        }
    }

public:
    MyQueue() {

    }

    void push(int x) {
        inStack.push(x);
    }

    int pop() {
        transferElements();
        int frontElement = outStack.top();
        outStack.pop();
        return frontElement;
    }

    int peek() {
        transferElements();
        return outStack.top();
    }

    bool empty() {
        return inStack.empty() && outStack.empty();
    }
};