#include <thread>
#include <mutex>
#include <condition_variable>

class ZeroEvenOdd {
private:
    int n;
    int current;
    std::mutex mtx;
    std::condition_variable cv;

public:
    ZeroEvenOdd(int n) {
        this->n = n;
        this->current = 0;
    }

    // You may call this function multiple times, even from different threads.
    void zero(std::function<void(int)> printNumber) {
        for (int i = 1; i <= n; ++i) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this] { return current == 0; });
            printNumber(0);
            if (i % 2 == 1) {
                current = 1;
            } else {
                current = 2;
            }
            cv.notify_all();
        }
    }

    void even(std::function<void(int)> printNumber) {
        for (int i = 2; i <= n; i += 2) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this] { return current == 2; });
            printNumber(i);
            current = 0;
            cv.notify_all();
        }
    }

    void odd(std::function<void(int)> printNumber) {
        for (int i = 1; i <= n; i += 2) {
            std::unique_lock<std::mutex> lock(mtx);
            cv.wait(lock, [this] { return current == 1; });
            printNumber(i);
            current = 0;
            cv.notify_all();
        }
    }
};