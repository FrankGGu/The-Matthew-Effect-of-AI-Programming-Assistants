#include <iostream>
#include <vector>
#include <mutex>
#include <condition_variable>

class Solution {
public:
    void foo(std::function<void()> printFoo) {
        for (int i = 0; i < 100; i++) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this] { return turn == 0; });
            printFoo();
            turn = 1;
            cv.notify_one();
        }
    }

    void bar(std::function<void()> printBar) {
        for (int i = 0; i < 100; i++) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this] { return turn == 1; });
            printBar();
            turn = 0;
            cv.notify_one();
        }
    }

private:
    std::mutex mtx;
    std::condition_variable cv;
    int turn = 0;
};