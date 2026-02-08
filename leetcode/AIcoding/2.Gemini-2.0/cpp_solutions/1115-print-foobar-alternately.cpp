#include <thread>
#include <mutex>
#include <condition_variable>

class FooBar {
private:
    int n;
    std::mutex m;
    std::condition_variable cv;
    bool fooTurn;

public:
    FooBar(int n) {
        this->n = n;
        fooTurn = true;
    }

    void foo(std::function<void()> printFoo) {

        for (int i = 0; i < n; i++) {
            std::unique_lock<std::mutex> lock(m);
            cv.wait(lock, [this]{ return fooTurn; });
            printFoo();
            fooTurn = false;
            cv.notify_one();
        }
    }

    void bar(std::function<void()> printBar) {

        for (int i = 0; i < n; i++) {
            std::unique_lock<std::mutex> lock(m);
            cv.wait(lock, [this]{ return !fooTurn; });
            printBar();
            fooTurn = true;
            cv.notify_one();
        }
    }
};