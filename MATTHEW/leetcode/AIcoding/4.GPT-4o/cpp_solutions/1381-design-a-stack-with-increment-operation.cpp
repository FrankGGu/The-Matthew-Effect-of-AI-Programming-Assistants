class CustomStack {
public:
    vector<int> stack;
    vector<int> increments;
    int maxSize;

    CustomStack(int maxSize) {
        this->maxSize = maxSize;
    }

    void push(int x) {
        if (stack.size() < maxSize) {
            stack.push_back(x);
            increments.push_back(0);
        }
    }

    int pop() {
        if (stack.empty()) return -1;
        int index = stack.size() - 1;
        int value = stack.back() + increments[index];
        stack.pop_back();
        increments.pop_back();
        if (!stack.empty()) increments[index - 1] += increments[index];
        return value;
    }

    void increment(int k, int val) {
        int size = stack.size();
        if (size > 0) {
            increments[min(k, size) - 1] += val;
        }
    }
};