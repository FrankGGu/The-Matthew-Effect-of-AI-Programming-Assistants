class Checkout {
private:
    std::queue<int> queue;
public:
    Checkout() {

    }

    int get_max() {
        if (queue.empty()) {
            return -1;
        }
        int max_val = INT_MIN;
        std::queue<int> temp = queue;
        while (!temp.empty()) {
            max_val = std::max(max_val, temp.front());
            temp.pop();
        }
        return max_val;
    }

    void add(int value) {
        queue.push(value);
    }

    int remove() {
        if (queue.empty()) {
            return -1;
        }
        int front = queue.front();
        queue.pop();
        return front;
    }
};