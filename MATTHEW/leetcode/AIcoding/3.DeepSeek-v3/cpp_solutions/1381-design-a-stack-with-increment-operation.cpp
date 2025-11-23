class CustomStack {
public:
    vector<int> stack;
    int maxSize;

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
        int n = min(k, (int)stack.size());
        for (int i = 0; i < n; ++i) {
            stack[i] += val;
        }
    }
};