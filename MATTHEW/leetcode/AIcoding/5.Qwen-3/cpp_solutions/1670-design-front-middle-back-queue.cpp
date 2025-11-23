#include <iostream>
#include <vector>
#include <deque>

using namespace std;

class Solution {
public:
    deque<int> dq;

    void pushFront(int val) {
        dq.push_front(val);
    }

    void pushMiddle(int val) {
        dq.insert(dq.begin() + dq.size() / 2, val);
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
        int mid = dq.size() / 2;
        int val = dq[mid];
        dq.erase(dq.begin() + mid);
        return val;
    }

    int popBack() {
        if (dq.empty()) return -1;
        int val = dq.back();
        dq.pop_back();
        return val;
    }
};