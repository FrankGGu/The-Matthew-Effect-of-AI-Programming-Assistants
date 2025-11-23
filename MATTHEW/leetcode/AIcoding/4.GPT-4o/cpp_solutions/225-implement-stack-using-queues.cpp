class MyStack {
public:
    queue<int> q1, q2;

    MyStack() {}

    void push(int x) {
        q1.push(x);
    }

    int pop() {
        while (q1.size() > 1) {
            q2.push(q1.front());
            q1.pop();
        }
        int top = q1.front();
        q1.pop();
        swap(q1, q2);
        return top;
    }

    int top() {
        while (q1.size() > 1) {
            q2.push(q1.front());
            q1.pop();
        }
        int top = q1.front();
        q2.push(top);
        q1.pop();
        swap(q1, q2);
        return top;
    }

    bool empty() {
        return q1.empty();
    }
};