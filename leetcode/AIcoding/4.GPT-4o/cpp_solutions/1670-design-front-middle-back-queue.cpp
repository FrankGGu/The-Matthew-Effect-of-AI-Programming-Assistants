class FrontMiddleBackQueue {
public:
    deque<int> q;

    FrontMiddleBackQueue() {}

    void pushFront(int val) {
        q.push_front(val);
    }

    void pushMiddle(int val) {
        q.insert(q.begin() + q.size() / 2, val);
    }

    void pushBack(int val) {
        q.push_back(val);
    }

    int popFront() {
        if (q.empty()) return -1;
        int val = q.front();
        q.pop_front();
        return val;
    }

    int popMiddle() {
        if (q.empty()) return -1;
        int index = (q.size() - 1) / 2;
        int val = q[index];
        q.erase(q.begin() + index);
        return val;
    }

    int popBack() {
        if (q.empty()) return -1;
        int val = q.back();
        q.pop_back();
        return val;
    }
};