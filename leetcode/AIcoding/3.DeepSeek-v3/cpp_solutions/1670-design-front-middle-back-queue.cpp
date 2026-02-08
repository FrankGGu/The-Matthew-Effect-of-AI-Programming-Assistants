class FrontMiddleBackQueue {
private:
    deque<int> left;
    deque<int> right;

    void balance() {
        if (left.size() > right.size()) {
            right.push_front(left.back());
            left.pop_back();
        } else if (right.size() > left.size() + 1) {
            left.push_back(right.front());
            right.pop_front();
        }
    }

public:
    FrontMiddleBackQueue() {

    }

    void pushFront(int val) {
        left.push_front(val);
        balance();
    }

    void pushMiddle(int val) {
        if (left.size() < right.size()) {
            left.push_back(val);
        } else {
            right.push_front(val);
        }
        balance();
    }

    void pushBack(int val) {
        right.push_back(val);
        balance();
    }

    int popFront() {
        if (left.empty() && right.empty()) {
            return -1;
        }
        int val;
        if (!left.empty()) {
            val = left.front();
            left.pop_front();
        } else {
            val = right.front();
            right.pop_front();
        }
        balance();
        return val;
    }

    int popMiddle() {
        if (left.empty() && right.empty()) {
            return -1;
        }
        int val;
        if (left.size() == right.size()) {
            val = left.back();
            left.pop_back();
        } else {
            val = right.front();
            right.pop_front();
        }
        balance();
        return val;
    }

    int popBack() {
        if (left.empty() && right.empty()) {
            return -1;
        }
        int val;
        if (!right.empty()) {
            val = right.back();
            right.pop_back();
        } else {
            val = left.back();
            left.pop_back();
        }
        balance();
        return val;
    }
};