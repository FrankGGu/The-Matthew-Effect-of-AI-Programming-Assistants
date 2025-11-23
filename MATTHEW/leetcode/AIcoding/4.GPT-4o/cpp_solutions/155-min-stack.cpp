class MinStack {
public:

    MinStack() {
        minStack.push(INT_MAX);
    }

    void push(int x) {
        dataStack.push(x);
        minStack.push(min(minStack.top(), x));
    }

    void pop() {
        dataStack.pop();
        minStack.pop();
    }

    int top() {
        return dataStack.top();
    }

    int getMin() {
        return minStack.top();
    }

private:
    stack<int> dataStack;
    stack<int> minStack;
};