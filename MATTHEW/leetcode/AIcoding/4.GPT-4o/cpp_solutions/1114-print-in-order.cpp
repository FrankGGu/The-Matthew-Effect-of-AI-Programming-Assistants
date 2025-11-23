#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>

class Foo {
private:
    std::mutex mtx;
    std::condition_variable cv;
    int step = 1;

public:
    Foo() {}

    void first(std::function<void()> printFirst) {
        std::lock_guard<std::mutex> lock(mtx);
        printFirst();
        step = 2;
        cv.notify_all();
    }

    void second(std::function<void()> printSecond) {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, [this]() { return step == 2; });
        printSecond();
        step = 3;
        cv.notify_all();
    }

    void third(std::function<void()> printThird) {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, [this]() { return step == 3; });
        printThird();
    }
};