#include <list>
#include <algorithm> // For std::advance

class FrontMiddleBackQueue {
private:
    std::list<int> data;

public:
    FrontMiddleBackQueue() {
        // The list 'data' is default-constructed as empty.
    }

    void pushFront(int val) {
        data.push_front(val);
    }

    void pushMiddle(int val) {
        std::list<int>::iterator it = data.begin();
        int insert_idx = (data.size() - 1) / 2;
        std::advance(it, insert_idx);
        data.insert(it, val);
    }

    void pushBack(int val) {
        data.push_back(val);
    }

    int popFront() {
        if (data.empty()) {
            return -1;
        }
        int val = data.front();
        data.pop_front();
        return val;
    }

    int popMiddle() {
        if (data.empty()) {
            return -1;
        }
        std::list<int>::iterator it = data.begin();
        int pop_idx = data.size() / 2;
        std::advance(it, pop_idx);
        int val = *it;
        data.erase(it);
        return val;
    }

    int popBack() {
        if (data.empty()) {
            return -1;
        }
        int val = data.back();
        data.pop_back();
        return val;
    }
};