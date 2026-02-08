#include <deque>

class FrontMiddleBackQueue {
public:
    FrontMiddleBackQueue() {

    }

    void pushFront(int val) {
        dq.push_front(val);
    }

    void pushMiddle(int val) {
        int size = dq.size();
        int mid = size / 2;
        std::deque<int> temp;
        for (int i = 0; i < mid; ++i) {
            temp.push_back(dq.front());
            dq.pop_front();
        }
        dq.push_front(val);
        for (int i = 0; i < mid; ++i) {
            dq.push_front(temp.back());
            temp.pop_back();
        }
    }

    void pushBack(int val) {
        dq.push_back(val);
    }

    int popFront() {
        if (dq.empty()) return -1;
        int val = dq.front();
        dq.pop_front();
        return val;
    }

    int popMiddle() {
        if (dq.empty()) return -1;
        int size = dq.size();
        int mid = (size - 1) / 2;
        std::deque<int> temp;
        for (int i = 0; i < mid; ++i) {
            temp.push_back(dq.front());
            dq.pop_front();
        }
        int val = dq.front();
        dq.pop_front();
        for (int i = 0; i < mid; ++i) {
            dq.push_front(temp.back());
            temp.pop_back();
        }
        return val;
    }

    int popBack() {
        if (dq.empty()) return -1;
        int val = dq.back();
        dq.pop_back();
        return val;
    }

private:
    std::deque<int> dq;
};