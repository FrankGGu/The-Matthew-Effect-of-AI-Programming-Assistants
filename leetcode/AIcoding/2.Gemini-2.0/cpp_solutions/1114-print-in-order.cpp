#include <thread>
#include <functional>
#include <mutex>
#include <condition_variable>

class Foo {
private:
    std::mutex m;
    std::condition_variable cv;
    int flag;

public:
    Foo() : flag(1) {}

    void first(std::function<void()> printFirst) {
        std::unique_lock<std::mutex> lock(m);
        printFirst();
        flag = 2;
        cv.notify_all();
    }

    void second(std::function<void()> printSecond) {
        std::unique_lock<std::mutex> lock(m);
        cv.wait(lock, [this] { return flag == 2; });
        printSecond();
        flag = 3;
        cv.notify_all();
    }

    void third(std::function<void()> printThird) {
        std::unique_lock<std::mutex> lock(m);
        cv.wait(lock, [this] { return flag == 3; });
        printThird();
    }
};