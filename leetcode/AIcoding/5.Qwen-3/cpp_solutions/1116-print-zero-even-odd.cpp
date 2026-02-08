#include <iostream>
#include <vector>
#include <mutex>
#include <condition_variable>

using namespace std;

class Solution {
private:
    int n;
    int count = 0;
    mutex mtx;
    condition_variable cv;
    bool zeroTurn = true;

public:
    Solution(int n) : n(n) {}

    void zero(function<void(int)> printNumber) {
        unique_lock<mutex> lock(mtx);
        while (count < 2 * n) {
            if (zeroTurn) {
                printNumber(0);
                zeroTurn = false;
                count++;
                cv.notify_all();
            } else {
                cv.wait(lock);
            }
        }
    }

    void even(function<void(int)> printNumber) {
        unique_lock<mutex> lock(mtx);
        while (count < 2 * n) {
            if (!zeroTurn && count % 2 == 1) {
                printNumber(count / 2 + 1);
                zeroTurn = true;
                count++;
                cv.notify_all();
            } else {
                cv.wait(lock);
            }
        }
    }

    void odd(function<void(int)> printNumber) {
        unique_lock<mutex> lock(mtx);
        while (count < 2 * n) {
            if (!zeroTurn && count % 2 == 0) {
                printNumber(count / 2 + 1);
                zeroTurn = true;
                count++;
                cv.notify_all();
            } else {
                cv.wait(lock);
            }
        }
    }
};