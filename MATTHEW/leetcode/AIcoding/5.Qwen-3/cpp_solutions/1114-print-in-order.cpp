#include <iostream>
#include <vector>
#include <mutex>
#include <condition_variable>

using namespace std;

class Solution {
private:
    mutex mtx;
    condition_variable cv;
    int turn;

public:
    Solution() : turn(1) {}

    void first(function<void()> printFirst) {
        unique_lock<mutex> lock(mtx);
        cv.wait(lock, [this]{ return turn == 1; });
        printFirst();
        turn = 2;
        cv.notify_all();
    }

    void second(function<void()> printSecond) {
        unique_lock<mutex> lock(mtx);
        cv.wait(lock, [this]{ return turn == 2; });
        printSecond();
        turn = 3;
        cv.notify_all();
    }

    void third(function<void()> printThird) {
        unique_lock<mutex> lock(mtx);
        cv.wait(lock, [this]{ return turn == 3; });
        printThird();
        turn = 1;
        cv.notify_all();
    }
};