#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>

class Foo {
private:
    std::mutex m;
    std::condition_variable cv;
    int count;

public:
    Foo() {
        count = 1;
    }

    void first(std::function<void()> printFirst) {
        std::unique_lock<std::mutex> lock(m);
        printFirst();
        count = 2;
        cv.notify_all();
    }

    void second(std::function<void()> printSecond) {
        std::unique_lock<std::mutex> lock(m);
        cv.wait(lock, [this]{return count == 2;});
        printSecond();
        count = 3;
        cv.notify_all();
    }

    void third(std::function<void()> printThird) {
        std::unique_lock<std::mutex> lock(m);
        cv.wait(lock, [this]{return count == 3;});
        printThird();
    }
};